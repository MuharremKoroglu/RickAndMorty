//
//  RickAndMortyTests.swift
//  RickAndMortyTests
//
//  Created by Muharrem Köroğlu on 10.06.2023.
//

import XCTest
@testable import RickAndMorty

final class RickAndMortyCharacterTests: XCTestCase {
    
    private var viewModel : CharacterViewModel!
    private var mockService : MockCharacterApiCallService!
    private var mockDelegate : MockCharacterViewModelDelegate!


    override func setUpWithError() throws {
        mockService = MockCharacterApiCallService()
        viewModel = CharacterViewModel(service: mockService)
        mockDelegate = MockCharacterViewModelDelegate()
        viewModel.delegate = mockDelegate
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockService = nil
    }


    func testFetchCharacterData_whenAPICallSuccess_showCharacterData() throws {

        mockService.fetchedMockCharacter = .success(mockDelegate.mockCharacterArray)
        
        let expectation = self.expectation(description: "Delegate methods expectation")
        mockDelegate.expectation = expectation
        
        viewModel.fetchCharacterData(request: RMRequest(endPoints: .character))
        
        waitForExpectations(timeout: 5.0, handler: nil)
        
        XCTAssertTrue(mockDelegate.didWorkedSelectedCharacterFunc)
        XCTAssertEqual(mockDelegate.mockCharacterArray.first?.name, "Fake Character")
        
        
    }
    
    func testFetchCharacterData_whenAPIFailure_showNoCharacter() throws {
        mockService.fetchedMockCharacter = .failure(.DidntParseData)
        viewModel.fetchCharacterData(request: RMRequest(endPoints: .character))
        XCTAssertNil(mockDelegate.mockCharacterArray.first?.name)
    }
    


}


class MockCharacterApiCallService: RMApiCallService {
    
    var fetchedMockCharacter : Result<[RickAndMorty.Character], RickAndMorty.ApiError>?
    
    func executeApiCall<T>(request: RickAndMorty.RMRequest, dataType: T.Type, completion: @escaping (Result<T, RickAndMorty.ApiError>) -> Void) where T : Decodable, T : Encodable {
        if let result = fetchedMockCharacter as? Result<T, RickAndMorty.ApiError> {
            completion(result)
        }
    }
 }
 
class MockCharacterViewModelDelegate: CharacterViewModelDelegate {
    
    var mockCharacterArray : [Character] = []
    var didWorkedSelectedCharacterFunc : Bool = false
    var expectation: XCTestExpectation?
    
    func didLoadInitialCharacter() {
        let mockCharacter : Character = Character(id: 1, name: "Fake Character", status: .alive, species: "", type: "", gender: .male, origin: CharacterOrigin(name: "", url: ""), location: CharacterLocation(name: "", url: ""), image: "", episode: [""], url: "", created: "")
        mockCharacterArray.append(mockCharacter)
        expectation?.fulfill()
    }
    
    func didSelectedCharacter(with character: [RickAndMorty.Character]) {
        didWorkedSelectedCharacterFunc = true
    }
    

 }


