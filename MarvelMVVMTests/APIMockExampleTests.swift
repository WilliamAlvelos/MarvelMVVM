//
//  APIMockExampleTests.swift
//  APIMockExampleTests
//
//  Created by William Alvelos on 7/25/19.
//  Copyright © 2019 William Alvelos. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import APIMockExample


class APIMockExampleTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchCharactersShouldSuccessWithStubs() {
        
        stub(condition: isPath("/v1/public/characters/1016823?apikey=8a13919f4c92b10f75223805677c8d37&ts=1564160488&hash=64e397dbc903566774a08084834190c4")) { response in
            return OHHTTPStubsResponse(fileAtPath: OHPathForFile("heroes.json", type(of: self))!, statusCode: 200, headers: nil)
        }
        
        let service = CharacterService()
        let filter = FilterModel(orderBy: .name, name: nil, nameStartsWith: nil, limit: 10, offset: 0)
        service.fetchCharacters(with: filter) { (result) in
            XCTAssertTrue(result.isSuccess)
        }
    }
    
    func testFetchCharactersShouldSuccess() {
        let service = CharacterServiceMock()
        let filter = FilterModel(orderBy: .name, name: nil, nameStartsWith: nil, limit: 10, offset: 0)
        service.fetchCharacters(with: filter) { (result) in
            XCTAssertTrue(result.isSuccess)
        }
    }
}
