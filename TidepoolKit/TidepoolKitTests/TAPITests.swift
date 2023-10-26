//
//  TAPITests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 3/3/20.
//  Copyright © 2020 Tidepool Project. All rights reserved.
//

import XCTest
@testable import TidepoolKit

class TAPITests: XCTestCase {
    var api: TAPI!
    var environment: TEnvironment!
    let authenticationToken = randomString
    let userId = randomString

    override func setUp() {
        super.setUp()

        URLProtocolMock.handlers = []

        self.api = TAPI(automaticallyFetchEnvironments: false)
        self.api.urlSessionConfiguration.protocolClasses = [URLProtocolMock.self]
        self.environment = TEnvironment(host: "test.org", port: 443)
    }

    override func tearDown() {
        XCTAssertTrue(URLProtocolMock.handlers.isEmpty)
    }

    static var randomString: String { UUID().uuidString }

    struct TestError: Error {}

    func setUpNetworkError() {
        URLProtocolMock.handlers[0].error = TestError()
    }

    func setUpRequestNotAuthenticated() {
        URLProtocolMock.handlers[0].success?.statusCode = 401
    }

    func setUpRequestNotAuthorized() {
        URLProtocolMock.handlers[0].success?.statusCode = 403
    }

    func setUpResponseNotAuthenticated() {
        URLProtocolMock.handlers[0].success?.headers = nil
    }

    func setUpResponseMalformedJSON() {
        URLProtocolMock.handlers[0].success?.body = nil
    }
}

class TAPIEnvironmentTests: TAPITests {
    func testImplicitEnvironments() {
        XCTAssertEqual(api.environments, [TEnvironment(host: "app.tidepool.org", port: 443)])
    }
}

class TAPIURLSessionConfigurationTests: TAPITests {
    func testDefaultURLSessionConfiguration() {
        let urlSessionConfiguration = api.urlSessionConfiguration
        XCTAssertNotNil(urlSessionConfiguration.httpAdditionalHeaders)
        XCTAssertNotNil(urlSessionConfiguration.httpAdditionalHeaders?["User-Agent"])
        XCTAssertNotNil(urlSessionConfiguration.protocolClasses)
    }
}

class TAPILoginTests: TAPITests {
    let email = randomString
    let password = randomString

    override func setUp() {
        super.setUp()

        URLProtocolMock.handlers = [URLProtocolMock.Handler(validator: URLProtocolMock.Validator(url: "https://test.org/auth/login",
                                                                                                 method: "POST",
                                                                                                 headers: ["Authorization": "Basic \(Data("\(email):\(password)".utf8).base64EncodedString())"]),
                                                            success: URLProtocolMock.Success(statusCode: 201,
                                                                                             headers: ["X-Tidepool-Session-Token": authenticationToken],
                                                                                             body: LoginResponse(userId: userId, email: email, emailVerified: true, termsAccepted: "2010-01-01T12:34:56Z")))]
    }

    func testNetworkError() {
        setUpNetworkError()
        guard let error = performRequest(), case .network(let networkError) = error else {
            XCTFail()
            return
        }
        XCTAssertNotNil(networkError)
    }

    func testRequestNotAuthenticated() {
        setUpRequestNotAuthenticated()
        guard let error = performRequest(), case .requestNotAuthenticated = error else {
            XCTFail()
            return
        }
    }

    func testRequestEmailNotVerified() {
        setUpRequestNotAuthorized()
        guard let error = performRequest(), case .requestEmailNotVerified = error else {
            XCTFail()
            return
        }
    }

    func testResponseNotAuthenticated() {
        setUpResponseNotAuthenticated()
        guard let error = performRequest(), case .responseNotAuthenticated = error else {
            XCTFail()
            return
        }
    }

    func testResponseMalformedJSON() {
        setUpResponseMalformedJSON()
        guard let error = performRequest(), case .responseMalformedJSON = error else {
            XCTFail()
            return
        }
    }

    func testTermsOfUseNotAccepted() {
        URLProtocolMock.handlers[0].success?.set(body: LoginResponse(userId: userId, email: email, emailVerified: true))
        guard let error = performRequest(), case .requestTermsOfServiceNotAccepted = error else {
            XCTFail()
            return
        }
    }

    func testSuccess() {
        guard performRequest() == nil else {
            XCTFail()
            return
        }
        XCTAssertEqual(api.session?.environment, environment)
        XCTAssertEqual(api.session?.authenticationToken, authenticationToken)
        XCTAssertEqual(api.session?.userId, userId)
        XCTAssertNotNil(api.session?.trace)
    }

    private func performRequest() -> TError? {
        let expectation = XCTestExpectationWithError()
        api.login(environment: environment, email: email, password: password) { expectation.fulfill($0) }
        XCTAssertNotEqual(XCTWaiter.wait(for: [expectation], timeout: 10), .timedOut)
        return expectation.error
    }
}

class TAPIInfoTests: TAPITests {

    static let info = TInfo(versions: TInfo.Versions(loop: TInfo.Versions.Loop(minimumSupported: "1.2.3", criticalUpdateNeeded: ["1.0.0", "1.1.0"])))
    
    override func setUp() {
        super.setUp()

        URLProtocolMock.handlers = [URLProtocolMock.Handler(validator: URLProtocolMock.Validator(url: "https://test.org/info", method: "GET"),
                                                            success: URLProtocolMock.Success(statusCode: 200, body: TAPIInfoTests.info))]
    }

    func testNetworkError() {
        setUpNetworkError()
        guard case .failure(let error) = performRequest(environment), case .network(let networkError) = error else {
            XCTFail()
            return
        }
        XCTAssertNotNil(networkError)
    }

    func testRequestNotAuthenticated() {
        setUpRequestNotAuthenticated()
        guard case .failure(let error) = performRequest(environment), case .requestNotAuthenticated = error else {
            XCTFail()
            return
        }
    }

    func testRequestNotAuthorized() {
        setUpRequestNotAuthorized()
        guard case .failure(let error) = performRequest(environment), case .requestNotAuthorized = error else {
            XCTFail()
            return
        }
    }

    func testResponseMalformedJSON() {
        setUpResponseMalformedJSON()
        guard case .failure(let error) = performRequest(environment), case .responseMalformedJSON = error else {
            XCTFail()
            return
        }
    }

    func testSuccess() {
        guard case .success(let info) = performRequest(environment) else {
            XCTFail()
            return
        }
        XCTAssertEqual(info, TAPIInfoTests.info)
    }

    func testSuccessUsingSessionEnvironment() {
        let env = TEnvironment(host: "foo.bar.baz", port: 123)
        let session = TSession(environment: env, authenticationToken: authenticationToken, userId: userId)
        api.session = session
        URLProtocolMock.handlers = [URLProtocolMock.Handler(validator: URLProtocolMock.Validator(url: "http://foo.bar.baz:123/info", method: "GET"),
                                                            success: URLProtocolMock.Success(statusCode: 200, body: TAPIInfoTests.info))]

        guard case .success(let info) = performRequest(nil) else {
            XCTFail()
            return
        }
        XCTAssertEqual(info, TAPIInfoTests.info)
    }
    
    private func performRequest(_ environment: TEnvironment?) -> Result<TInfo, TError>? {
        let expectation = XCTestExpectationWithResult<TInfo, TError>()
        api.getInfo(environment: environment) { expectation.fulfill($0) }
        XCTAssertNotEqual(XCTWaiter.wait(for: [expectation], timeout: 10), .timedOut)
        return expectation.result
    }
}

class TAPISessionTests: TAPITests {
    var session: TSession!
    var headers: [String: String]!
    var refreshAuthenticationToken = randomString
    var refreshHandler: URLProtocolMock.Handler!

    override func setUp() {
        super.setUp()

        session = TSession(environment: environment, authenticationToken: authenticationToken, userId: userId)
        headers = ["X-Tidepool-Session-Token": authenticationToken, "X-Tidepool-Trace-Session": session.trace!]
        refreshHandler = URLProtocolMock.Handler(validator: URLProtocolMock.Validator(url: "https://test.org/auth/login", method: "GET", headers: headers),
                                                 success: URLProtocolMock.Success(statusCode: 200, headers: ["X-Tidepool-Session-Token": refreshAuthenticationToken]))

        api.session = session
    }
}

class TAPIRefreshTests: TAPISessionTests {
    override func setUp() {
        super.setUp()

        URLProtocolMock.handlers = [refreshHandler]
    }

    func testNetworkError() {
        setUpNetworkError()
        guard let error = performRequest(), case .network(let networkError) = error else {
            XCTFail()
            return
        }
        XCTAssertNotNil(networkError)
    }

    func testRequestNotAuthenticated() {
        setUpRequestNotAuthenticated()
        guard let error = performRequest(), case .requestNotAuthenticated = error else {
            XCTFail()
            return
        }
    }

    func testResponseNotAuthenticated() {
        setUpResponseNotAuthenticated()
        guard let error = performRequest(), case .responseNotAuthenticated = error else {
            XCTFail()
            return
        }
    }

    func testSuccess() {
        guard performRequest() == nil else {
            XCTFail()
            return
        }
        XCTAssertEqual(api.session?.environment, session.environment)
        XCTAssertEqual(api.session?.authenticationToken, refreshAuthenticationToken)
        XCTAssertEqual(api.session?.userId, session.userId)
        XCTAssertEqual(api.session?.trace, session.trace)
    }

    private func performRequest() -> TError? {
        let expectation = XCTestExpectationWithError()
        api.refreshSession() { expectation.fulfill($0) }
        XCTAssertNotEqual(XCTWaiter.wait(for: [expectation], timeout: 10), .timedOut)
        return expectation.error
    }
}

class TAPILogoutTests: TAPISessionTests {
    override func setUp() {
        super.setUp()

        URLProtocolMock.handlers = [URLProtocolMock.Handler(validator: URLProtocolMock.Validator(url: "https://test.org/auth/logout", method: "POST", headers: headers),
                                                            success: URLProtocolMock.Success(statusCode: 200))]
    }

    func testNetworkError() {
        setUpNetworkError()
        guard let error = performRequest(), case .network(let networkError) = error else {
            XCTFail()
            return
        }
        XCTAssertNotNil(networkError)
    }

    func testRequestNotAuthenticated() {
        setUpRequestNotAuthenticated()
        guard let error = performRequest(), case .requestNotAuthenticated = error else {
            XCTFail()
            return
        }
    }

    func testSuccess() {
        guard performRequest() == nil else {
            XCTFail()
            return
        }
        XCTAssertNil(api.session)
    }

    private func performRequest() -> TError? {
        let expectation = XCTestExpectationWithError()
        api.logout() { expectation.fulfill($0) }
        XCTAssertNotEqual(XCTWaiter.wait(for: [expectation], timeout: 10), .timedOut)
        return expectation.error
    }
}

class TAPIRefreshSessionTests: TAPISessionTests {
    override func setUpRequestNotAuthenticated() {
        super.setUpRequestNotAuthenticated()
        URLProtocolMock.handlers.append(refreshHandler)
        URLProtocolMock.handlers.append(URLProtocolMock.handlers[0])
        URLProtocolMock.handlers[2].validator.headers = ["X-Tidepool-Session-Token": refreshAuthenticationToken, "X-Tidepool-Trace-Session": session.trace!]
    }

    func setUpSessionWantsRefresh() {
        api.session = TSession(session: session, createdDate: Date().addingTimeInterval(-TSession.refreshInterval).addingTimeInterval(.seconds(-1)))

        URLProtocolMock.handlers.insert(refreshHandler, at: 0)
        URLProtocolMock.handlers[1].validator.headers = ["X-Tidepool-Session-Token": refreshAuthenticationToken, "X-Tidepool-Trace-Session": session.trace!]
    }
}

class TAPIGetProfileTests: TAPIRefreshSessionTests {
    override func setUp() {
        super.setUp()

        URLProtocolMock.handlers = [URLProtocolMock.Handler(validator: URLProtocolMock.Validator(url: "https://test.org/metadata/\(userId)/profile", method: "GET", headers: headers),
                                                            success: URLProtocolMock.Success(statusCode: 200, headers: headers, body: TProfileTests.profile))]
    }

    func testNetworkError() {
        setUpNetworkError()
        guard case .failure(let error) = performRequest(), case .network(let networkError) = error else {
            XCTFail()
            return
        }
        XCTAssertNotNil(networkError)
    }

    func testRequestNotAuthenticated() {
        setUpRequestNotAuthenticated()
        guard case .failure(let error) = performRequest(), case .requestNotAuthenticated = error else {
            XCTFail()
            return
        }
    }

    func testRequestNotAuthorized() {
        setUpRequestNotAuthorized()
        guard case .failure(let error) = performRequest(), case .requestNotAuthorized = error else {
            XCTFail()
            return
        }
    }

    func testResponseMalformedJSON() {
        setUpResponseMalformedJSON()
        guard case .failure(let error) = performRequest(), case .responseMalformedJSON = error else {
            XCTFail()
            return
        }
    }

    func testSuccess() {
        guard case .success(let profile) = performRequest() else {
            XCTFail()
            return
        }
        XCTAssertEqual(profile, TProfileTests.profile)
    }

    func testSuccessAfterRefresh() {
        setUpSessionWantsRefresh()
        testSuccess()
    }

    private func performRequest() -> Result<TProfile, TError>? {
        let expectation = XCTestExpectationWithResult<TProfile, TError>()
        api.getProfile() { expectation.fulfill($0) }
        XCTAssertNotEqual(XCTWaiter.wait(for: [expectation], timeout: 10), .timedOut)
        return expectation.result
    }
}

class TAPIClaimPrescriptionTests: TAPIRefreshSessionTests {
    var prescriptionClaim: TPrescriptionClaim!

    override func setUp() {
        super.setUp()

        prescriptionClaim = TPrescriptionClaim(accessCode: "ABCDEF", birthday: "2004-01-04")
        URLProtocolMock.handlers = [URLProtocolMock.Handler(validator: URLProtocolMock.Validator(url: "https://test.org/v1/patients/\(userId)/prescriptions", method: "POST", headers: headers, body: prescriptionClaim),
                                                            success: URLProtocolMock.Success(statusCode: 201, headers: headers, body: TPrescriptionTests.prescription))]
    }

    func testNetworkError() {
        setUpNetworkError()
        guard case .failure(let error) = performRequest(), case .network(let networkError) = error else {
            XCTFail()
            return
        }
        XCTAssertNotNil(networkError)
    }

    func testRequestNotAuthenticated() {
        setUpRequestNotAuthenticated()
        guard case .failure(let error) = performRequest(), case .requestNotAuthenticated = error else {
            XCTFail()
            return
        }
    }

    func testRequestNotAuthorized() {
        setUpRequestNotAuthorized()
        guard case .failure(let error) = performRequest(), case .requestNotAuthorized = error else {
            XCTFail()
            return
        }
    }

    func testResponseMalformedJSON() {
        setUpResponseMalformedJSON()
        guard case .failure(let error) = performRequest(), case .responseMalformedJSON = error else {
            XCTFail()
            return
        }
    }

    func testSuccess() {
        guard case .success(let claimedPrescription) = performRequest() else {
            XCTFail()
            return
        }
        XCTAssertEqual(claimedPrescription, TPrescriptionTests.prescription)
    }

    func testSuccessAfterRefresh() {
        setUpSessionWantsRefresh()
        testSuccess()
    }

    private func performRequest() -> Result<TPrescription, TError>? {
        let expectation = XCTestExpectationWithResult<TPrescription, TError>()
        api.claimPrescription(prescriptionClaim: prescriptionClaim) { expectation.fulfill($0) }
        XCTAssertNotEqual(XCTWaiter.wait(for: [expectation], timeout: 10), .timedOut)
        return expectation.result
    }
}

class TAPIListDataSetsTests: TAPIRefreshSessionTests {
    override func setUp() {
        super.setUp()

        let url = "https://test.org/v1/users/\(userId)/data_sets?client.name=org.tidepool.Example&deleted=true&deviceId=ExampleDeviceId"
        URLProtocolMock.handlers = [URLProtocolMock.Handler(validator: URLProtocolMock.Validator(url: url, method: "GET", headers: headers),
                                                            success: URLProtocolMock.Success(statusCode: 200, headers: headers, body: [TDataSetTests.dataSet]))]
    }

    func testNetworkError() {
        setUpNetworkError()
        guard case .failure(let error) = performRequest(), case .network(let networkError) = error else {
            XCTFail()
            return
        }
        XCTAssertNotNil(networkError)
    }

    func testRequestNotAuthenticated() {
        setUpRequestNotAuthenticated()
        guard case .failure(let error) = performRequest(), case .requestNotAuthenticated = error else {
            XCTFail()
            return
        }
    }

    func testRequestNotAuthorized() {
        setUpRequestNotAuthorized()
        guard case .failure(let error) = performRequest(), case .requestNotAuthorized = error else {
            XCTFail()
            return
        }
    }

    func testResponseMalformedJSON() {
        setUpResponseMalformedJSON()
        guard case .failure(let error) = performRequest(), case .responseMalformedJSON = error else {
            XCTFail()
            return
        }
    }

    func testSuccess() {
        guard case .success(let dataSets) = performRequest() else {
            XCTFail()
            return
        }
        XCTAssertEqual(dataSets, [TDataSetTests.dataSet])
    }

    func testSuccessAfterRefresh() {
        setUpSessionWantsRefresh()
        testSuccess()
    }

    private func performRequest() -> Result<[TDataSet], TError>? {
        let expectation = XCTestExpectationWithResult<[TDataSet], TError>()
        api.listDataSets(filter: TDataSetFilterTests.filter) { expectation.fulfill($0) }
        XCTAssertNotEqual(XCTWaiter.wait(for: [expectation], timeout: 10), .timedOut)
        return expectation.result
    }
}

class TAPICreateDataSetTests: TAPIRefreshSessionTests {
    var dataSet: TDataSet!

    override func setUp() {
        super.setUp()

        dataSet = TDataSet(dataSetType: .continuous, client: TDataSetClientTests.client, deduplicator: TDataSet.Deduplicator(name: .dataSetDeleteOrigin))
        URLProtocolMock.handlers = [URLProtocolMock.Handler(validator: URLProtocolMock.Validator(url: "https://test.org/v1/users/\(userId)/data_sets", method: "POST", headers: headers, body: dataSet),
                                                            success: URLProtocolMock.Success(statusCode: 200, headers: headers, body: LegacyResponse.Success(data: TDataSetTests.dataSet)))]
    }

    func testNetworkError() {
        setUpNetworkError()
        guard case .failure(let error) = performRequest(), case .network(let networkError) = error else {
            XCTFail()
            return
        }
        XCTAssertNotNil(networkError)
    }

    func testRequestNotAuthenticated() {
        setUpRequestNotAuthenticated()
        guard case .failure(let error) = performRequest(), case .requestNotAuthenticated = error else {
            XCTFail()
            return
        }
    }

    func testRequestNotAuthorized() {
        setUpRequestNotAuthorized()
        guard case .failure(let error) = performRequest(), case .requestNotAuthorized = error else {
            XCTFail()
            return
        }
    }

    func testResponseMalformedJSON() {
        setUpResponseMalformedJSON()
        guard case .failure(let error) = performRequest(), case .responseMalformedJSON = error else {
            XCTFail()
            return
        }
    }

    func testSuccess() {
        guard case .success(let createdDataSet) = performRequest() else {
            XCTFail()
            return
        }
        XCTAssertEqual(createdDataSet, TDataSetTests.dataSet)
    }

    func testSuccessAfterRefresh() {
        setUpSessionWantsRefresh()
        testSuccess()
    }

    private func performRequest() -> Result<TDataSet, TError>? {
        let expectation = XCTestExpectationWithResult<TDataSet, TError>()
        api.createDataSet(dataSet) { expectation.fulfill($0) }
        XCTAssertNotEqual(XCTWaiter.wait(for: [expectation], timeout: 10), .timedOut)
        return expectation.result
    }
}

class TAPIListDataTests: TAPIRefreshSessionTests {
    override func setUp() {
        super.setUp()

        let url = "https://test.org/data/\(userId)?startDate=\(Date.testJSONString)"
        URLProtocolMock.handlers = [URLProtocolMock.Handler(validator: URLProtocolMock.Validator(url: url, method: "GET", headers: headers),
                                                            success: URLProtocolMock.Success(statusCode: 200, headers: headers, body: [TCBGDatumTests.cbg, TFoodDatumTests.food]))]
    }

    func testNetworkError() {
        setUpNetworkError()
        guard case .failure(let error) = performRequest(), case .network(let networkError) = error else {
            XCTFail()
            return
        }
        XCTAssertNotNil(networkError)
    }

    func testRequestNotAuthenticated() {
        setUpRequestNotAuthenticated()
        guard case .failure(let error) = performRequest(), case .requestNotAuthenticated = error else {
            XCTFail()
            return
        }
    }

    func testRequestNotAuthorized() {
        setUpRequestNotAuthorized()
        guard case .failure(let error) = performRequest(), case .requestNotAuthorized = error else {
            XCTFail()
            return
        }
    }

    func testResponseMalformedJSON() {
        setUpResponseMalformedJSON()
        guard case .failure(let error) = performRequest(), case .responseMalformedJSON = error else {
            XCTFail()
            return
        }
    }

    func testSuccess() {
        guard case .success((let data, let malformed)) = performRequest() else {
            XCTFail()
            return
        }
        XCTAssertEqual(data, [TCBGDatumTests.cbg, TFoodDatumTests.food])
        XCTAssertEqual(malformed.count, 0)
    }

    func testSuccessAfterRefresh() {
        setUpSessionWantsRefresh()
        testSuccess()
    }

    private func performRequest() -> Result<([TDatum], [String: [String: Any]]), TError>? {
        let expectation = XCTestExpectationWithResult<([TDatum], [String: [String: Any]]), TError>()
        api.listData(filter: TDatum.Filter(startDate: Date.test)) { expectation.fulfill($0) }
        XCTAssertNotEqual(XCTWaiter.wait(for: [expectation], timeout: 10), .timedOut)
        return expectation.result
    }
}

class TAPICreateDataTests: TAPIRefreshSessionTests {
    let dataSetId = randomString
    let data = [TCBGDatumTests.cbg, TFoodDatumTests.food]

    override func setUp() {
        super.setUp()

        URLProtocolMock.handlers = [URLProtocolMock.Handler(validator: URLProtocolMock.Validator(url: "https://test.org/v1/data_sets/\(dataSetId)/data", method: "POST", headers: headers, body: data),
                                                            success: URLProtocolMock.Success(statusCode: 200, headers: headers, body: LegacyResponse.Success<DataResponse>(data: DataResponse())))]
    }

    func testNetworkError() {
        setUpNetworkError()
        guard let error = performRequest(), case .network(let networkError) = error else {
            XCTFail()
            return
        }
        XCTAssertNotNil(networkError)
    }

    func testRequestNotAuthenticated() {
        setUpRequestNotAuthenticated()
        guard let error = performRequest(), case .requestNotAuthenticated = error else {
            XCTFail()
            return
        }
    }

    func testRequestNotAuthorized() {
        setUpRequestNotAuthorized()
        guard let error = performRequest(), case .requestNotAuthorized = error else {
            XCTFail()
            return
        }
    }

    func testRequestMalformedJSON() {
        let errors = [TError.Detail(code: "code-123", title: "title-123", detail: "detail-123"),
                      TError.Detail(code: "code-456", title: "title-456", detail: "detail-456"),
                      TError.Detail(code: "code-789", title: "title-789", detail: "detail-789")]
        URLProtocolMock.handlers[0].success = URLProtocolMock.Success(statusCode: 400, headers: headers, body: LegacyResponse.Failure(errors: errors))
        guard let error = performRequest(), case .requestMalformedJSON(_, _, let malformedJSONErrors) = error else {
            XCTFail()
            return
        }
        XCTAssertEqual(malformedJSONErrors, errors)
    }

    func testResponseMalformedJSON() {
        setUpResponseMalformedJSON()
        guard let error = performRequest(), case .responseMalformedJSON = error else {
            XCTFail()
            return
        }
    }

    func testSuccess() {
        guard performRequest() == nil else {
            XCTFail()
            return
        }
    }

    func testSuccessAfterRefresh() {
        setUpSessionWantsRefresh()
        testSuccess()
    }

    private func performRequest() -> TError? {
        let expectation = XCTestExpectationWithError()
        api.createData(data, dataSetId: dataSetId) { expectation.fulfill($0) }
        XCTAssertNotEqual(XCTWaiter.wait(for: [expectation], timeout: 10), .timedOut)
        return expectation.error
    }
}

class TAPIDeleteDataTests: TAPIRefreshSessionTests {
    let dataSetId = randomString
    let selectors = [TDatum.Selector(id: randomString), TDatum.Selector(origin: TDatum.Selector.Origin(id: randomString))]

    override func setUp() {
        super.setUp()

        URLProtocolMock.handlers = [URLProtocolMock.Handler(validator: URLProtocolMock.Validator(url: "https://test.org/v1/data_sets/\(dataSetId)/data", method: "DELETE", headers: headers, body: selectors),
                                                            success: URLProtocolMock.Success(statusCode: 200, headers: headers, body: LegacyResponse.Success<DataResponse>(data: DataResponse())))]
    }

    func testNetworkError() {
        setUpNetworkError()
        guard let error = performRequest(), case .network(let networkError) = error else {
            XCTFail()
            return
        }
        XCTAssertNotNil(networkError)
    }

    func testRequestNotAuthenticated() {
        setUpRequestNotAuthenticated()
        guard let error = performRequest(), case .requestNotAuthenticated = error else {
            XCTFail()
            return
        }
    }

    func testRequestNotAuthorized() {
        setUpRequestNotAuthorized()
        guard let error = performRequest(), case .requestNotAuthorized = error else {
            XCTFail()
            return
        }
    }

    func testSuccess() {
        guard performRequest() == nil else {
            XCTFail()
            return
        }
    }

    func testSuccessAfterRefresh() {
        setUpSessionWantsRefresh()
        testSuccess()
    }

    private func performRequest() -> TError? {
        let expectation = XCTestExpectationWithError()
        api.deleteData(withSelectors: selectors, dataSetId: dataSetId) { expectation.fulfill($0) }
        XCTAssertNotEqual(XCTWaiter.wait(for: [expectation], timeout: 10), .timedOut)
        return expectation.error
    }
}

class TAPIVerifyDeviceTests: TAPIRefreshSessionTests {
    let deviceToken = randomString.data(using: .utf8)!

    override func setUp() {
        super.setUp()

        let body = TAPI.VerifyDeviceRequestBody(deviceToken: deviceToken.base64EncodedString())
        URLProtocolMock.handlers = [URLProtocolMock.Handler(validator: URLProtocolMock.Validator(url: "https://test.org/v1/device_check/verify", method: "POST", headers: headers, body: body),
                                                            success: URLProtocolMock.Success(statusCode: 200, headers: headers, body: TAPI.VerifyDeviceResponseBody(valid: true)))]
    }

    func testNetworkError() {
        setUpNetworkError()
        guard case .failure(let error) = performRequest(), case .network(let networkError) = error else {
            XCTFail()
            return
        }
        XCTAssertNotNil(networkError)
    }

    func testRequestNotAuthenticated() {
        setUpRequestNotAuthenticated()
        guard case .failure(let error) = performRequest(), case .requestNotAuthenticated = error else {
            XCTFail()
            return
        }
    }

    func testRequestNotAuthorized() {
        setUpRequestNotAuthorized()
        guard case .failure(let error) = performRequest(), case .requestNotAuthorized = error else {
            XCTFail()
            return
        }
    }

    func testResponseMalformedJSON() {
        setUpResponseMalformedJSON()
        guard case .failure(let error) = performRequest(), case .responseMalformedJSON = error else {
            XCTFail()
            return
        }
    }

    func testSuccess() {
        guard case .success(let valid) = performRequest() else {
            XCTFail()
            return
        }
        XCTAssertTrue(valid)
    }

    func testSuccessInvalid() {
        URLProtocolMock.handlers[0].success = URLProtocolMock.Success(statusCode: 200, headers: headers, body: TAPI.VerifyDeviceResponseBody(valid: false))
        guard case .success(let valid) = performRequest() else {
            XCTFail()
            return
        }
        XCTAssertFalse(valid)
    }

    func testSuccessAfterRefresh() {
        setUpSessionWantsRefresh()
        testSuccess()
    }

    private func performRequest() -> Result<Bool, TError>? {
        let expectation = XCTestExpectationWithResult<Bool, TError>()
        api.verifyDevice(deviceToken: deviceToken) { expectation.fulfill($0) }
        XCTAssertNotEqual(XCTWaiter.wait(for: [expectation], timeout: 10), .timedOut)
        return expectation.result
    }
}

fileprivate extension TSession {
    init(session: TSession, createdDate: Date) {
        self.init(environment: session.environment, authenticationToken: session.authenticationToken, userId: session.userId, trace: session.trace, createdDate: createdDate)
    }
}
