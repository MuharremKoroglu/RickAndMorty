//
//  RickAndMortyUITests.swift
//  RickAndMortyUITests
//
//  Created by Muharrem Köroğlu on 10.06.2023.
//

import XCTest

final class RickAndMortyUITests: XCTestCase {
    
    func testCharacterTabBar() throws {
        
        let timeout: TimeInterval = 5
        
        // MARK: -Start the Application
        let app = XCUIApplication()
        app.launch()
        let collectionViewsQuery = app.collectionViews
        
        // MARK: -Wait1
        let wait1 = app.waitForExistence(timeout: timeout)
        
        XCTAssertTrue(wait1)

        // MARK: -Set up Location CollectionView Go Left
        let verticalCollectionViewGoLeft = collectionViewsQuery.containing(.other, identifier:"Vertical scroll bar, 11 pages").element
        
        XCTAssertTrue(verticalCollectionViewGoLeft.exists)

        verticalCollectionViewGoLeft.swipeLeft(velocity: 2000)
        verticalCollectionViewGoLeft.swipeLeft(velocity: 2000)
        verticalCollectionViewGoLeft.swipeLeft(velocity: 2000)

        
        // MARK: -Set up Earth (Replacement Dimension) Location Button
        let locationButton1 = collectionViewsQuery.staticTexts["Earth (Replacement Dimension)"]
        
        XCTAssertTrue(locationButton1.exists)
        
        locationButton1.tap()
        
        // MARK: -Wait2
        let wait2 = app.waitForExistence(timeout: timeout)
        
        XCTAssertTrue(wait2)
        
        // MARK: -Set up Character CollectionView
        let horizontalCollectionView = collectionViewsQuery.containing(.other, identifier:"Horizontal scroll bar, 1 page").element
        
        XCTAssertTrue(horizontalCollectionView.exists)
        
        horizontalCollectionView.swipeUp()
        horizontalCollectionView.swipeUp()
        horizontalCollectionView.swipeDown()
        horizontalCollectionView.swipeDown()
                
        // MARK: -Set up Character CollectionView Summer Smith Cell
        let characterCell = collectionViewsQuery.cells.otherElements.containing(.staticText, identifier:"Summer Smith").element
        
        XCTAssertTrue(characterCell.exists)

        characterCell.tap()
        
        horizontalCollectionView.swipeUp()
    
        // MARK: -Set up Character Episodes CollectionView
        let characterDetailEpisodeCollectionView = collectionViewsQuery.children(matching: .scrollView).element
        
        XCTAssertTrue(characterDetailEpisodeCollectionView.exists)
        
        characterDetailEpisodeCollectionView.swipeLeft()
        characterDetailEpisodeCollectionView.swipeLeft()

        // MARK: -Set up Character Detail Episodes CollectionView Rixty Minutes Cell
        let characterEpisode = collectionViewsQuery.staticTexts["Rixty Minutes"]
        
        XCTAssertTrue(characterEpisode.exists)

        characterEpisode.tap()
        
        // MARK: -Wait3
        let wait3 = app.waitForExistence(timeout: timeout)
        
        XCTAssertTrue(wait3)

        horizontalCollectionView.swipeUp(velocity: 3000)
        horizontalCollectionView.swipeUp(velocity: 3000)
        horizontalCollectionView.swipeDown(velocity: 3000)
        horizontalCollectionView.swipeDown(velocity: 3000)
        
        // MARK: -Set up Character Detail Episodes CollectionView Rixty Minutes Cell
        let episodeDetailNavigationBar = app.navigationBars["Episode"].buttons["SUMMER SMITH"]
        
        XCTAssertTrue(episodeDetailNavigationBar.exists)
        
        episodeDetailNavigationBar.tap()
        
        horizontalCollectionView.swipeDown()

        
        // MARK: -Set up Character Detail Screen Navigation Bar
        let navigationBar = app.navigationBars["SUMMER SMITH"].buttons["Characters"]
        
        XCTAssertTrue(navigationBar.exists)

        navigationBar.tap()
        
        // MARK: -Wait4
        let wait4 = app.waitForExistence(timeout: timeout)
        
        XCTAssertTrue(wait4)

        // MARK: -Set up Location CollectionView Go Right
        let verticalCollectionViewGoRight = collectionViewsQuery.containing(.other, identifier:"Vertical scroll bar, 20 pages").element
        
        XCTAssertTrue(verticalCollectionViewGoRight.exists)

        verticalCollectionViewGoRight.swipeRight(velocity: 5000)
        verticalCollectionViewGoRight.swipeRight(velocity: 2000)

        
        // MARK: -Set up Earth (C-137) Location Button
        let locationButton2 = collectionViewsQuery.staticTexts["Earth (C-137)"]
        
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
        let wait1 = app.wait(for: .runningForeground, timeout: timeout)
        
        XCTAssertTrue(wait1)

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
        let wait2 = app.wait(for: .runningForeground, timeout: timeout)
        
        XCTAssertTrue(wait2)


        // MARK: -Set up Episode Detail Screen Navigation Bar
        let navigationBar = app.navigationBars["Episode"].buttons["Episodes"]
        
        XCTAssertTrue(navigationBar.exists)

        navigationBar.tap()

        tableView.swipeDown(velocity: 5000)
        tableView.swipeDown(velocity: 5000)
        tableView.swipeDown(velocity: 5000)
        
        

    }

}
