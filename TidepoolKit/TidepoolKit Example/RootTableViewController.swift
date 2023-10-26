//
//  RootTableViewController.swift
//  TidepoolKit Example
//
//  Created by Darin Krauss on 1/10/20.
//  Copyright © 2020 Tidepool Project. All rights reserved.
//

import os.log
import UIKit
import TidepoolKit
import TidepoolKitUI

class RootTableViewController: UITableViewController, TAPIObserver {
    private let api: TAPI
    private var environment: TEnvironment? {
        didSet {
            UserDefaults.standard.environment = environment
            updateViews()
        }
    }
    private var dataSetId: String? {
        didSet {
            UserDefaults.standard.dataSetId = dataSetId
            if dataSetId == nil {
                self.datumSelectors = nil
            }
            updateViews()
        }
    }
    private var datumSelectors: [TDatum.Selector]? {
        didSet {
            updateViews()
        }
    }

    private let logging = Logging()

    required init?(coder: NSCoder) {
        self.api = TAPI(session: UserDefaults.standard.session)
        self.environment = UserDefaults.standard.environment
        self.dataSetId = UserDefaults.standard.dataSetId

        super.init(coder: coder)

        api.logging = logging
        api.addObserver(self)
    }

    deinit {
        api.removeObserver(self)
    }

    func apiDidUpdateSession(_ session: TSession?) {
        UserDefaults.standard.session = session
        if let session = session {
            self.environment = session.environment
        } else {
            self.dataSetId = nil
        }
        updateViews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(TextButtonTableViewCell.self, forCellReuseIdentifier: TextButtonTableViewCell.className)

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(share))

        updateViews()
    }

    private func updateViews() {
        tableView.reloadData()
        navigationItem.rightBarButtonItem?.isEnabled = api.session != nil
    }

    private struct SharedStatus: Codable, Equatable {
        let session: TSession
        let dataSetId: String?
    }

    @objc func share() {
        guard let session = api.session,
            let data = try? JSONEncoder.pretty.encode(SharedStatus(session: session, dataSetId: dataSetId)),
            let text = String(data: data, encoding: .utf8) else
        {
            return
        }
        let activityItem = UTF8TextFileActivityItem(name: "Status")
        if let error = activityItem.write(text: text) {
            present(UIAlertController(error: error), animated: true)
        } else {
            present(UIActivityViewController(activityItems: [activityItem], applicationActivities: nil), animated: true)
        }
    }

    // MARK: - UITableView

    private enum Section: Int, CaseIterable {
        case status
        case authentication
        case profile
        case dataSet
        case datum
    }

    private enum Authentication: Int, CaseIterable {
        case login
        case refresh
        case logout
    }

    private enum Profile: Int, CaseIterable {
        case get
    }

    private enum DataSet: Int, CaseIterable {
        case list
        case create
    }

    private enum Datum: Int, CaseIterable {
        case list
        case create
        case delete
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch Section(rawValue: section)! {
        case .status:
            return NSLocalizedString("Status", comment: "The title for the header of the status section")
        case .authentication:
            return NSLocalizedString("Authentication", comment: "The title for the header of the authentication section")
        case .profile:
            return NSLocalizedString("Profile", comment: "The title for the header of the profile section")
        case .dataSet:
            return NSLocalizedString("Data Set", comment: "The title for the header of the data set section")
        case .datum:
            return NSLocalizedString("Datum", comment: "The title for the header of the datum section")
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Section(rawValue: section)! {
        case .status:
            return 1
        case .authentication:
            return Authentication.allCases.count
        case .profile:
            return Profile.allCases.count
        case .dataSet:
            return DataSet.allCases.count
        case .datum:
            return Datum.allCases.count
        }
    }

    private let defaultStatusLabelText = NSLocalizedString("-", comment: "The default status label text")

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Section(rawValue: indexPath.section)! {
        case .status:
            let cell = tableView.dequeueReusableCell(withIdentifier: StatusTableViewCell.className, for: indexPath) as! StatusTableViewCell
            cell.environmentLabel?.text = environment?.description ?? defaultStatusLabelText
            cell.authenticationTokenLabel?.text = api.session?.authenticationToken ?? defaultStatusLabelText
            cell.userIdLabel?.text = api.session?.userId ?? defaultStatusLabelText
            cell.dataSetIdLabel?.text = dataSetId ?? defaultStatusLabelText
            return cell
        case .authentication:
            let cell = tableView.dequeueReusableCell(withIdentifier: TextButtonTableViewCell.className, for: indexPath) as! TextButtonTableViewCell
            switch Authentication(rawValue: indexPath.row)! {
            case .login:
                cell.textLabel?.text = NSLocalizedString("Login", comment: "The text label of the authentication login cell")
                cell.accessoryType = .disclosureIndicator
                cell.isEnabled = api.session == nil
            case .refresh:
                cell.textLabel?.text = NSLocalizedString("Refresh", comment: "The text label of the authentication refresh cell")
                cell.isEnabled = api.session != nil
            case .logout:
                cell.textLabel?.text = NSLocalizedString("Logout", comment: "The text label of the authentication logout cell")
                cell.isEnabled = api.session != nil
            }
            return cell
        case .profile:
            let cell = tableView.dequeueReusableCell(withIdentifier: TextButtonTableViewCell.className, for: indexPath) as! TextButtonTableViewCell
            cell.accessoryType = .disclosureIndicator
            cell.isEnabled = api.session != nil
            switch Profile(rawValue: indexPath.row)! {
            case .get:
                cell.textLabel?.text = NSLocalizedString("Get Profile", comment: "The text label of the get profile cell")
            }
            return cell
        case .dataSet:
            let cell = tableView.dequeueReusableCell(withIdentifier: TextButtonTableViewCell.className, for: indexPath) as! TextButtonTableViewCell
            cell.accessoryType = .disclosureIndicator
            cell.isEnabled = api.session != nil
            switch DataSet(rawValue: indexPath.row)! {
            case .list:
                cell.textLabel?.text = NSLocalizedString("List Data Sets", comment: "The text label of the list data sets cell")
            case .create:
                cell.textLabel?.text = NSLocalizedString("Create Data Set", comment: "The text label of the create data set cell")
            }
            return cell
        case .datum:
            let cell = tableView.dequeueReusableCell(withIdentifier: TextButtonTableViewCell.className, for: indexPath) as! TextButtonTableViewCell
            cell.accessoryType = .disclosureIndicator
            switch Datum(rawValue: indexPath.row)! {
            case .list:
                cell.textLabel?.text = NSLocalizedString("List Data", comment: "The text label of the list data cell")
                cell.isEnabled = api.session != nil
            case .create:
                cell.textLabel?.text = NSLocalizedString("Create Data", comment: "The text label of the create data cell")
                cell.isEnabled = api.session != nil && dataSetId != nil
            case .delete:
                cell.textLabel?.text = NSLocalizedString("Delete Data", comment: "The text label of the delete data cell")
                cell.isEnabled = api.session != nil && dataSetId != nil && datumSelectors != nil
            }
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        switch Section(rawValue: indexPath.section)! {
        case .status:
            return false
        case .authentication:
            switch Authentication(rawValue: indexPath.row)! {
            case .login:
                return api.session == nil
            default:
                return api.session != nil
            }
        case .datum:
            switch Datum(rawValue: indexPath.row)! {
            case .create:
                return api.session != nil && dataSetId != nil
            case .delete:
                return api.session != nil && dataSetId != nil && datumSelectors != nil
            default:
                return api.session != nil
            }
        default:
            return api.session != nil
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch Section(rawValue: indexPath.section)! {
        case .status:
            break
        case .authentication:
            let cell = tableView.cellForRow(at: indexPath) as! TextButtonTableViewCell
            cell.isLoading = true
            switch Authentication(rawValue: indexPath.row)! {
            case .login:
                login(completion: cell.stopLoading)
            case .refresh:
                refresh(completion: cell.stopLoading)
            case .logout:
                logout(completion: cell.stopLoading)
            }
        case .profile:
            let cell = tableView.cellForRow(at: indexPath) as! TextButtonTableViewCell
            cell.isLoading = true
            getProfile(completion: cell.stopLoading)
        case .dataSet:
            let cell = tableView.cellForRow(at: indexPath) as! TextButtonTableViewCell
            cell.isLoading = true
            switch DataSet(rawValue: indexPath.row)! {
            case .list:
                listDataSets(completion: cell.stopLoading)
            case .create:
                createDataSet(completion: cell.stopLoading)
            }
        case .datum:
            let cell = tableView.cellForRow(at: indexPath) as! TextButtonTableViewCell
            cell.isLoading = true
            switch Datum(rawValue: indexPath.row)! {
            case .list:
                listData(completion: cell.stopLoading)
            case .create:
                createData(completion: cell.stopLoading)
            case .delete:
                deleteData(completion: cell.stopLoading)
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - Authentication

    private func login(completion: @escaping () -> Void) {
        var loginSignupViewController = api.loginSignupViewController()
        loginSignupViewController.loginSignupDelegate = self
        loginSignupViewController.environment = environment
        present(loginSignupViewController, animated: true)
        completion()
    }

    private func refresh(completion: @escaping () -> Void) {
        api.refreshSession() { error in
            DispatchQueue.main.async {
                if let error = error {
                    self.present(UIAlertController(error: error), animated: true)
                }
                completion()
            }
        }
    }

    private func logout(completion: @escaping () -> Void) {
        api.logout() { error in
            DispatchQueue.main.async {
                if let error = error {
                    self.present(UIAlertController(error: error), animated: true)
                }
                completion()
            }
        }
    }

    // MARK: - Profile

    private func getProfile(completion: @escaping () -> Void) {
        api.getProfile() { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    self.present(UIAlertController(error: error), animated: true)
                case .success(let profile):
                    self.display(profile, withTitle: "Get Profile")
                }
                completion()
            }
        }
    }

    // MARK: - Data Set

    private func listDataSets(completion: @escaping () -> Void) {
        let filter = TDataSet.Filter(clientName: Bundle.main.bundleIdentifier)
        api.listDataSets(filter: filter) { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    self.present(UIAlertController(error: error), animated: true)
                case .success(let dataSets):
                    self.dataSetId = dataSets.first?.uploadId
                    self.display(dataSets, withTitle: "List Data Sets")
                }
                completion()
            }
        }
    }

    private func createDataSet(completion: @escaping () -> Void) {
        let client = TDataSet.Client(name: Bundle.main.bundleIdentifier!, version: Bundle.main.semanticVersion!)
        let deduplicator = TDataSet.Deduplicator(name: .none)
        let dataSet = TDataSet(dataSetType: .continuous, client: client, deduplicator: deduplicator)
        api.createDataSet(dataSet) { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    self.present(UIAlertController(error: error), animated: true)
                case .success(let dataSet):
                    self.dataSetId = dataSet.uploadId
                    self.display(dataSet, withTitle: "Create Data Set")
                }
                completion()
            }
        }
    }

    // MARK: - Datum

    private func listData(completion: @escaping () -> Void) {
        let filter = TDatum.Filter(dataSetId: dataSetId)
        api.listData(filter: filter) { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    self.present(UIAlertController(error: error), animated: true)
                case .success((let data, let malformed)):
                    if !malformed.isEmpty {
                        self.present(UIAlertController(error: "Response contains malformed data.") {
                            self.display(malformed, withTitle: "MALFORMED - List Data")
                        }, animated: true)
                    } else {
                        self.display(data, withTitle: "List Data")
                    }
                }
                completion()
            }
        }
    }

    private func createData(completion: @escaping () -> Void) {
        let data = Sample.Datum.data()
        api.createData(data, dataSetId: dataSetId!) { error in
            DispatchQueue.main.async {
                if let error = error {
                    if case .requestMalformedJSON(_, _, let errors) = error {
                        self.present(UIAlertController(error: "Response contains errors.") {
                            self.display(errors, withTitle: "ERRORS - Create Data")
                        }, animated: true)
                    } else {
                        self.present(UIAlertController(error: error), animated: true)
                    }
                } else {
                    self.datumSelectors = data.compactMap { $0.selector }
                }
                completion()
            }
        }
    }

    private func deleteData(completion: @escaping () -> Void) {
        api.deleteData(withSelectors: datumSelectors!, dataSetId: dataSetId!) { error in
            DispatchQueue.main.async {
                if let error = error {
                    self.present(UIAlertController(error: error), animated: true)
                } else {
                    self.datumSelectors = nil
                }
                completion()
            }
        }
    }

    // MARK: - Internal

    private func display<E>(_ encodable: E, withTitle title: String? = nil) where E: Encodable {
        do {
            display(try JSONEncoder.pretty.encode(encodable), withTitle: title)
        } catch let error {
            logging.error("Failure to encode object as JSON data [\(error)]")
            present(UIAlertController(error: "Failure to encode object as JSON data."), animated: true)
        }
    }

    private func display(_ object: Any, withTitle title: String? = nil) {
        do {
            display(try JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]), withTitle: title)
        } catch let error {
            logging.error("Failure to encode object as JSON data [\(error)]")
            present(UIAlertController(error: "Failure to encode object as JSON data."), animated: true)
        }
    }

    private func display(_ data: Data, withTitle title: String? = nil) {
        guard let text = String(data: data, encoding: .utf8) else {
            present(UIAlertController(error: "Failure to decode JSON data as string."), animated: true)
            return
        }
        show(TextViewController(text: text, withTitle: title), sender: self)
    }
}

extension RootTableViewController: TLoginSignupDelegate {
    func loginSignupDidComplete(completion: @escaping (Error?) -> Void) {
        DispatchQueue.main.async {
            self.dismiss(animated: true)
            completion(nil)
        }
    }

    func loginSignupCancelled() {
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }
}
