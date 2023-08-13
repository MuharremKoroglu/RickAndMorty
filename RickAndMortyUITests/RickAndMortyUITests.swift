//
//  RickAndMortyUITests.swift
//  RickAndMortyUITests
//
//  Created by Muharrem Köroğlu on 10.06.2023.
//

import XCTest

final class RickAndMortyUITests: XCTestCase {
    
    func testCharacterTabBar() throws {
        
        let timeout: TimeInterval = 3
        
        // MARK: -Start the Application
        let app = XCUIApplication()
        app.launch()
        
        // MARK: -Set up Location CollectionView
        let verticalCollectionView = app.collectionViews.containing(.other, identifier:"Vertical scroll bar, 11 pages").element
        
        XCTAssertTrue(verticalCollectionView.exists)

        verticalCollectionView.swipeLeft()
        
        // MARK: -Set up Anatomy Park Location Button
        let locationButton1 = app.collectionViews.staticTexts["Anatomy Park"]
        
        XCTAssertTrue(locationButton1.exists)
        
        locationButton1.tap()
        
        // MARK: -Wait1

        let wait1 = app.wait(for: .runningBackground, timeout: timeout)
        
        // MARK: -Set up Character CollectionView
        let horizontalCollectionView = XCUIApplication().collectionViews.containing(.other, identifier:"Horizontal scroll bar, 1 page").element
        
        XCTAssertTrue(horizontalCollectionView.exists)
        
        horizontalCollectionView.swipeUp()
        horizontalCollectionView.swipeUp()
                
        // MARK: -Set up Character CollectionView Roger Cell
        let characterCell = XCUIApplication().collectionViews.cells.otherElements.containing(.staticText, identifier:"Roger").element
        
        XCTAssertTrue(characterCell.exists)

        characterCell.tap()
        
        horizontalCollectionView.swipeUp()
        horizontalCollectionView.swipeDown()
        
        // MARK: -Set up Character Detail Screen Navigation Bar
        let navigationBar = app.navigationBars["ROGER"].buttons["Characters"]
        
        XCTAssertTrue(navigationBar.exists)

        navigationBar.tap()
        
        horizontalCollectionView.swipeDown()
        horizontalCollectionView.swipeDown()
        
        // MARK: -Wait2
        let wait2 = app.wait(for: .runningBackground, timeout: timeout)

        verticalCollectionView.swipeRight()
        
        // MARK: -Set up Earth (C-137) Location Button
        let locationButton2 = XCUIApplication().collectionViews.staticTexts["Earth (C-137)"]
        
        XCTAssertTrue(locationButton2.exists)

        locationButton2.tap()
        



        
                                                    
    }
    
    func testEpisodeTabBar () throws {
        
        let app = XCUIApplication()
        app.launch()
        
        let timeout: TimeInterval = 2
        
        // MARK: -Set up TabBar
        let tabBar = XCUIApplication().tabBars["Tab Bar"]
        
        XCTAssertTrue(tabBar.exists)

        // MARK: -Set up EpisodeTab
        let episodeTab = tabBar.buttons["Episodes"]
        
        XCTAssertTrue(episodeTab.exists)

        episodeTab.tap()
        
        // MARK: -Set up TableView
        let tableView = app.tables.element
        
        XCTAssertTrue(tableView.exists)

        tableView.swipeUp(velocity: 5000)
        tableView.swipeUp(velocity: 5000)
        tableView.swipeUp(velocity: 5000)
        
        // MARK: -Wait1
        let wait1 = app.wait(for: .runningBackground, timeout: timeout)

        tableView.swipeUp(velocity: 5000)
        tableView.swipeUp(velocity: 5000)

        // MARK: -Set up TableView Forgetting Sarick Mortshall Cell
        let cell = app.tables.staticTexts["Forgetting Sarick Mortshall"]
        
        XCTAssertTrue(cell.exists)

        cell.tap()

        // MARK: -Set up Character CollectionView in Episode Detail Screen
        let horizontalScrollBar1PageCollectionView = app.collectionViews.containing(.other, identifier:"Horizontal scroll bar, 1 page").element
        
        XCTAssertTrue(horizontalScrollBar1PageCollectionView.exists)

        horizontalScrollBar1PageCollectionView.swipeUp()
        horizontalScrollBar1PageCollectionView.swipeUp()
        
        // MARK: -Set up CollectionView Harold's Wife Cell
        let characterCell = app.collectionViews.cells.otherElements.containing(.staticText, identifier:"Harold's Wife").element
        
        XCTAssertTrue(characterCell.exists)

        characterCell.tap()
    
        horizontalScrollBar1PageCollectionView.swipeUp()
        horizontalScrollBar1PageCollectionView.swipeDown()
        
        // MARK: -Set up Character Detail Screen Navigation Bar
        let characterNavigationBar = app.navigationBars["HAROLD'S WIFE"].buttons["Episode"]
        
        XCTAssertTrue(characterNavigationBar.exists)

        characterNavigationBar.tap()

        horizontalScrollBar1PageCollectionView.swipeDown(velocity: 2000)

        // MARK: -Wait2
        let wait2 = app.wait(for: .runningBackground, timeout: timeout)

        // MARK: -Set up Episode Detail Screen Navigation Bar
        let navigationBar = app.navigationBars["Episode"].buttons["Episodes"]
        
        XCTAssertTrue(navigationBar.exists)

        navigationBar.tap()

        tableView.swipeDown(velocity: 5000)
        tableView.swipeDown(velocity: 5000)
        tableView.swipeDown(velocity: 5000)
        
        

    }

}
