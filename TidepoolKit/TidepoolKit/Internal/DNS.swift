//
//  DNS.swift
//  TidepoolKit
//
//  Created by Lennart Goedhart on 4/10/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import dnssd
import Foundation

enum DNSError: Error {
    case error(Int32, String?)
    case timeout
}

struct DNSSRVRecord: Equatable {
    let priority: UInt16
    let weight: UInt16
    let host: String
    let port: UInt16
}

extension DNSSRVRecord: Comparable {
    public static func < (lhs: DNSSRVRecord, rhs: DNSSRVRecord) -> Bool {
        if lhs.priority < rhs.priority {
            return true
        } else if lhs.priority > rhs.priority {
            return false
        }
        if lhs.weight > rhs.weight {
            return true
        } else if lhs.weight < rhs.weight {
            return false
        }
        if lhs.host < rhs.host {
            return true
        } else if lhs.host > rhs.host {
            return false
        }
        return lhs.port < rhs.port
    }
}

class DNS {
    static func lookupSRVRecords(for domainName: String, timeout: Int = 10, completion: @escaping (Result<[DNSSRVRecord], DNSError>) -> Void) {
        let serviceRef: UnsafeMutablePointer<DNSServiceRef?> = UnsafeMutablePointer.allocate(capacity: MemoryLayout<DNSServiceRef>.size)
        var context = DNSSRVRecordContext()

        let errorCode = DNSServiceQueryRecord(serviceRef, 0, 0, domainName, UInt16(kDNSServiceType_SRV), UInt16(kDNSServiceClass_IN), DNSSRVRecordCallback, &context)
        if errorCode != kDNSServiceErr_NoError {
            completion(.failure(.error(errorCode, nil)))
        }

        let serviceRefSockFD = DNSServiceRefSockFD(serviceRef.pointee)
        var serviceRefSockFDSet = fd_set()
        fdSet(serviceRefSockFD, set: &serviceRefSockFDSet)
        var timeout = timeval(tv_sec: timeout, tv_usec: 0)

        // Don't hang forever if there are no results
        switch select(serviceRefSockFD + 1, &serviceRefSockFDSet, nil, nil, &timeout) {
        case -1:
            completion(.failure(DNSError.error(errno, String(utf8String: strerror(errno)))))
        case 0:
            completion(.failure(DNSError.timeout))
        default:
            let errorCode = DNSServiceProcessResult(serviceRef.pointee)
            if errorCode != kDNSServiceErr_NoError {
                completion(.failure(.error(errorCode, nil)))
            } else if let error = context.error {
                completion(.failure(error))
            } else {
                completion(.success(context.records))
            }
        }

        DNSServiceRefDeallocate(serviceRef.pointee)
    }

    private static func fdSet(_ fd: Int32, set: inout fd_set) {
        let intOffset: Int32 = fd / 32
        let bitOffset: Int32 = fd % 32
        let mask: Int32 = 1 << bitOffset

        switch intOffset {
        case 0:
            set.fds_bits.0 = set.fds_bits.0 | mask
        case 1:
            set.fds_bits.1 = set.fds_bits.1 | mask
        case 2:
            set.fds_bits.2 = set.fds_bits.2 | mask
        case 3:
            set.fds_bits.3 = set.fds_bits.3 | mask
        case 4:
            set.fds_bits.4 = set.fds_bits.4 | mask
        case 5:
            set.fds_bits.5 = set.fds_bits.5 | mask
        case 6:
            set.fds_bits.6 = set.fds_bits.6 | mask
        case 7:
            set.fds_bits.7 = set.fds_bits.7 | mask
        case 8:
            set.fds_bits.8 = set.fds_bits.8 | mask
        case 9:
            set.fds_bits.9 = set.fds_bits.9 | mask
        case 10:
            set.fds_bits.10 = set.fds_bits.10 | mask
        case 11:
            set.fds_bits.11 = set.fds_bits.11 | mask
        case 12:
            set.fds_bits.12 = set.fds_bits.12 | mask
        case 13:
            set.fds_bits.13 = set.fds_bits.13 | mask
        case 14:
            set.fds_bits.14 = set.fds_bits.14 | mask
        case 15:
            set.fds_bits.15 = set.fds_bits.15 | mask
        case 16:
            set.fds_bits.16 = set.fds_bits.16 | mask
        case 17:
            set.fds_bits.17 = set.fds_bits.17 | mask
        case 18:
            set.fds_bits.18 = set.fds_bits.18 | mask
        case 19:
            set.fds_bits.19 = set.fds_bits.19 | mask
        case 20:
            set.fds_bits.20 = set.fds_bits.20 | mask
        case 21:
            set.fds_bits.21 = set.fds_bits.21 | mask
        case 22:
            set.fds_bits.22 = set.fds_bits.22 | mask
        case 23:
            set.fds_bits.23 = set.fds_bits.23 | mask
        case 24:
            set.fds_bits.24 = set.fds_bits.24 | mask
        case 25:
            set.fds_bits.25 = set.fds_bits.25 | mask
        case 26:
            set.fds_bits.26 = set.fds_bits.26 | mask
        case 27:
            set.fds_bits.27 = set.fds_bits.27 | mask
        case 28:
            set.fds_bits.28 = set.fds_bits.28 | mask
        case 29:
            set.fds_bits.29 = set.fds_bits.29 | mask
        case 30:
            set.fds_bits.30 = set.fds_bits.30 | mask
        case 31:
            set.fds_bits.31 = set.fds_bits.31 | mask
        default:
            break
        }
    }
}

private class DNSSRVRecordContext {
    var error: DNSError? = nil
    var records: [DNSSRVRecord] = []
}

private func DNSSRVRecordCallback(_: DNSServiceRef?, _: DNSServiceFlags, _: UInt32, errorCode: DNSServiceErrorType, _: UnsafePointer<Int8>?, _: UInt16, _: UInt16, readLength: UInt16, readBytes: UnsafeRawPointer?, _: UInt32, context: UnsafeMutableRawPointer?) -> Void {
    guard let context = context?.assumingMemoryBound(to: DNSSRVRecordContext.self).pointee else {
        return
    }
    guard context.error == nil else {
        return
    }
    guard errorCode == kDNSServiceErr_NoError else {
        context.error = .error(errorCode, nil)
        return
    }
    guard let readBytes = readBytes, readLength > 0 else {
        return
    }
    context.records.append(DNSSRVRecord(data: Data(bytes: readBytes, count: Int(readLength))))
}

private extension DNSSRVRecord {
    init(data: Data) {
        let priority = UInt16(bigEndian: data[0...2].withUnsafeBytes { $0.load(as: UInt16.self) })
        let weight = UInt16(bigEndian: data[2...4].withUnsafeBytes { $0.load(as: UInt16.self) })
        let port = UInt16(bigEndian: data[4...6].withUnsafeBytes { $0.load(as: UInt16.self) })

        // host is a byte array of format [size][ascii bytes][size][ascii bytes]...[null]
        // the size defines how many bytes ahead to read. The bytes represent each "chunk"
        // of the hostname. For example, "dev.tidepool.org", would be an array that looks like this (in hex):
        // 03 64 65 76 08 74 69 64 65 70 6F 6F 6C 03 6F 72 67 00
        var host = String(data: data.subdata(in: 6..<data.endIndex), encoding: String.Encoding.ascii) ?? ""

        // Process the raw host data into a host string by replacing the "size" bytes and the null terminator with an ascii period
        var pos = 0
        while pos < Int(data.endIndex) - 6 {
            let index = host.index(host.startIndex, offsetBy: pos)
            let size = Int(host[index].asciiValue!)
            host.replaceSubrange(index...index, with: ".")
            pos += size + 1
        }

        // Drop first and last period
        host = String(host.dropFirst())
        host = String(host.dropLast())

        self.priority = priority
        self.weight = weight
        self.host = host
        self.port = port
    }
}
