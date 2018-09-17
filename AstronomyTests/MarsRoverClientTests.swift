//
//  AstronomyTests.swift
//  AstronomyTests
//
//  Created by Samantha Gatt on 9/17/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import XCTest
@testable import Astronomy

class MockDataLoader: NetworkDataLoader {
    
    init(data: Data? = nil, error: Error? = nil) {
        self.data = data
        self.error = error
    }
    
    func loadData(from url: URL, completion: @escaping (Data?, Error?) -> Void) {
        self.url = url
        DispatchQueue.global().async {
            completion(self.data, self.error)
        }
    }
    
    func loadData(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        self.request = request
        DispatchQueue.global().async {
            completion(self.data, self.error)
        }
    }
    
    let data: Data?
    let error: Error?
    private(set) var request: URLRequest? = nil
    private(set) var url: URL? = nil
}

func urlComponents(_ componenst1: URLComponents, equalTo components2: URLComponents) -> Bool {
    var scratch1 = componenst1
    var scratch2 = components2
    
    scratch1.queryItems = []
    scratch2.queryItems = []
    if scratch1 != scratch2 {
        return false
    }
    
    // Compare query items
    if let queryItems1 = componenst1.queryItems,
        let queryItems2 = components2.queryItems {
        if Set(queryItems1) != Set(queryItems2) {
            return false
        }
    }
    
    return true
}

class AstronomyTests: XCTestCase {
    
    let testMarsRover = MarsRover(name: "Curiosity", launchDate: Date(), landingDate: Date(), status: .active, maxSol: 3, maxDate: Date(), numberOfPhotos: 90, solDescriptions: [SolDescription(sol: 4, totalPhotos: 9, cameras: ["Hi"])])
    
    func testFetchPhotosWithValidData() {
        
        let expectation = self.expectation(description: "Fetch photos")
        
        let mock = MockDataLoader(data: testJSON)
        let marsRoverClient = MarsRoverClient(dataLoader: mock)
        
        marsRoverClient.fetchPhotos(from: testMarsRover, onSol: 0) { (photoRefs, error) in
            
            XCTAssertNotNil(mock.url)
            let components = URLComponents(url: mock.url!, resolvingAgainstBaseURL: true)!
            let testComponents = URLComponents(url: URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/Curiosity/photos?sol=0&api_key=qzGsj0zsKk6CA9JZP1UjAbpQHabBfaPg2M5dGMB7")!, resolvingAgainstBaseURL: true)!
            XCTAssertTrue(urlComponents(components, equalTo: testComponents))
            
            XCTAssertNotNil(photoRefs)
            XCTAssertNil(error)
            
            let firstObject = photoRefs!.first!
            XCTAssertEqual(firstObject.id, 727)
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testFetchPhotosWithError() {
        let expectation = self.expectation(description: "Fetch photos")
        
        let mock = MockDataLoader(error: error)
        let marsRoverClient = MarsRoverClient(dataLoader: mock)
        
        let error = NSError(domain: "Error not found", code: 404, userInfo: nil)
        
        marsRoverClient.fetchPhotos(from: testMarsRover, onSol: 0) { (photoRefs, error) in
            XCTAssertNil(photoRefs)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
}
