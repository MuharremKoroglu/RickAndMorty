//
//  RickAndMortyEpisodeTests.swift
//  RickAndMortyTests
//
//  Created by Muharrem Köroğlu on 13.08.2023.
//

import XCTest
@testable import RickAndMorty

final class RickAndMortyEpisodeTests: XCTestCase {
    
    private var viewModel : RMEpisodeViewModel!
    private var mockEpisodeService : MockEpisodeApiCallService!
    private var mockEpisodeDelegate : MockEpisodeViewModelDelegate!

    override func setUpWithError() throws {
        mockEpisodeService = MockEpisodeApiCallService()
        viewModel = RMEpisodeViewModel(service: mockEpisodeService)
        mockEpisodeDelegate = MockEpisodeViewModelDelegate()
        viewModel.delegate = mockEpisodeDelegate
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockEpisodeService = nil
    }

    func testFetchEpisodeData_whenAPICallSuccess_showLocationData() throws {
        
        guard let mockEpisode = mockEpisodeDelegate.mockEpisodeArray.first else {
            return
        }
        mockEpisodeService.fetchedMockEpisode = .success(mockEpisode)
        
        let expectation = XCTestExpectation(description: "Delegate methods expectation")
        mockEpisodeDelegate.expectation = expectation
        
        viewModel.fetchEpisodes(request: RMRequest(endPoints: .episode))
        
        waitForExpectations(timeout: 5.0, handler: nil)
        
        guard let mockEpisodeName = mockEpisodeDelegate.mockEpisodeArray.first?.results.first?.name else {
            return
        }
        
        XCTAssertEqual(mockEpisodeName, "Fake Episode")

    }
    
    func testFetchEpisodeData_whenAPICallFailure_showLocationData () throws {
        mockEpisodeService.fetchedMockEpisode = .failure(.DidntParseData)
        viewModel.fetchEpisodes(request: RMRequest(endPoints: .episode))
        XCTAssertNil(mockEpisodeDelegate.mockEpisodeArray.first)
    }


}

class MockEpisodeApiCallService : RMApiCallService {
    
    var fetchedMockEpisode : Result<RickAndMorty.Episodes, RickAndMorty.ApiError>?
    
    func executeApiCall<T>(request: RickAndMorty.RMRequest, dataType: T.Type, completion: @escaping (Result<T, RickAndMorty.ApiError>) -> Void) where T : Decodable, T : Encodable {
        if let result = fetchedMockEpisode as? Result<T, RickAndMorty.ApiError> {
            completion(result)
        }
    }
    
}

class MockEpisodeViewModelDelegate : RMEpisodeViewModelDelegate {
    
    var mockEpisodeArray : [Episodes] = []
    var expectation : XCTestExpectation?
    
    func didLoadEpisode() {
        let mockEpisode : Episodes = Episodes(results: [EpisodesResult(id: 1, name: "Fake Episode", date: "", episode: "", characters: [""], url: "", created: "")], info: EpisodesInfo(count: 1, pages: 1, next: "", prev: ""))
        mockEpisodeArray.append(mockEpisode)
        expectation?.fulfill()
    }

}
