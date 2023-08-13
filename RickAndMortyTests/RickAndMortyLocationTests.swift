//
//  RickAndMortyLocationTests.swift
//  RickAndMortyTests
//
//  Created by Muharrem Köroğlu on 13.08.2023.
//

import XCTest
@testable import RickAndMorty

final class RickAndMortyLocationTests: XCTestCase {
    
    private var viewModel : LocationViewModel!
    private var mockLocationService : MockLocationApiCallService!
    private var mockLocationDelegate : MockLocationViewModelDelegate!

    override func setUpWithError() throws {
        mockLocationService = MockLocationApiCallService()
        viewModel = LocationViewModel(service: mockLocationService)
        mockLocationDelegate = MockLocationViewModelDelegate()
        viewModel.delegate = mockLocationDelegate
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockLocationService = nil
    }

    func testFetchLocationData_whenAPICallSuccess_showLocationData() throws {
        
        guard let mockLocation = mockLocationDelegate.mockLocationArray.first else {
            return
        }
        
        mockLocationService.fetchedMockLocation = .success(mockLocation)
        
        let expectation = self.expectation(description: "Delegate methods expectation")
        mockLocationDelegate.expectation = expectation
        
        viewModel.fetchLocationName(request: RMRequest(endPoints: .location))
        
        waitForExpectations(timeout: 5.0, handler: nil)
        
        guard let mockLocationName = mockLocationDelegate.mockLocationArray.first?.results.first?.name else {
            return
        }

        XCTAssertEqual(mockLocationName, "Fake Location")
        
    }
    
    func testFetchLocationData_whenAPICallFailure_showNoLocationData() throws {
        
        mockLocationService.fetchedMockLocation = .failure(.DidntParseData)
        viewModel.fetchLocationName(request: RMRequest(endPoints: .location))
        XCTAssertNil(mockLocationDelegate.mockLocationArray.first)
        
    }

}

class MockLocationApiCallService: RMApiCallService {
    
    var fetchedMockLocation : Result<RickAndMorty.Locations, RickAndMorty.ApiError>?
    
    func executeApiCall<T>(request: RickAndMorty.RMRequest, dataType: T.Type, completion: @escaping (Result<T, RickAndMorty.ApiError>) -> Void) where T : Decodable, T : Encodable {
        if let result = fetchedMockLocation as? Result<T, RickAndMorty.ApiError> {
            completion(result)
        }
    }
 }

class MockLocationViewModelDelegate : LocationViewModelDelegate {
    
    var mockLocationArray : [Locations] = []
    var expectation : XCTestExpectation?
    
    func didLoadLocations() {
        let mockLocation = Locations(results: [LocationResult(id: 1, name: "Fake Location", type: "", dimension: "", residents: [""], url: "", created: "")], info: LocationInfo(count: 1, pages: 1, next: "", prev: ""))
        mockLocationArray.append(mockLocation)
        expectation?.fulfill()
        
    }
    
}
