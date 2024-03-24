//
//  Food_Recipie_AppTests.swift
//  Food-Recipie-AppTests
//
//  Created by Dev on 3/20/24.
//

import XCTest
@testable import Food_Recipie_App

class Food_Recipie_AppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // MARK: - User Login Test Cases
    var loginViewModel: LoginViewModel!
    
    override func setUp() {
        super.setUp()
        loginViewModel = LoginViewModel()
        signupViewModel = SignupViewModel()
        homeViewModel = HomeViewModel()
        profileViewModel = ProfileViewModel()
        signOutExpectation = expectation(description: "Sign out expectation")
        
        
        let recipeData: [String: Any] = [
            "name": "Biryani",
            "image": "https://www.themealdb.com/images/media/meals/xrttsx1487339558.jpg",
            "requiredTime": "1 hr",
            "creator": "Chief John",
            "publishedDate": "2024-3-11",
            "ingredients": ["Rice": ["https://img.freepik.com/free-photo/top-view-raw-rice-inside-plate-dark-desk_179666-27235.jpg?size=626&ext=jpg&ga=GA1.1.1255960126.1709126803&semt=ais": "1kg"],
                            "Chicken": ["https://www.cookingclarified.com/wp-content/uploads/2010/09/Roast-Cooked-Chicken.jpg": "500g"]],
            "category": Category.lunch.rawValue,
            "procedure": [
                ["stepDetail": "First fry masala.", "stepNumber": 1],
                ["stepDetail": "Fry chicken and add water.", "stepNumber": 2],
                ["stepDetail": "When water boils add Rice.", "stepNumber": 3],
                ["stepDetail": "Cook until rice absorb water.", "stepNumber": 4],
                ["stepDetail": "Cook on low flame for 5 to 10 minutes", "stepNumber": 5]
            ],
            "rating": 4,
            "origin": Origin.indain.rawValue,
            "creatorImage": "https://media.gettyimages.com/id/1142230160/photo/beautiful-chef-working-in-a-kitchen-at-a-restaurant.jpg?s=1024x1024&w=gi&k=20&c=Beqs1KDEGnS2Ym567bv5K8JFq2wF8kGwgq-q822WQ7I=",
            "status": false
        ]
        mockRecipe = Recipe(data: recipeData)
        recipeDetailViewModel = RecipeDetailViewModel()
        recipeDetailViewModel.configure(with: mockRecipe)
        
    }
    
    func testUserLoginSuccess() {
        // Given
        let email = "a@a.com"
        let password = "123456"
        
        // When
        loginViewModel.LogIn(email: email, password: password) { success, error in
            // Then
            XCTAssertTrue(success)
            XCTAssertNil(error)
        }
    }
    func testUserLoginFailure() {
        // Given
        let email = "a@a.com"
        let password = "1234567"
        
        // When
        loginViewModel.LogIn(email: email, password: password) { success, error in
            // Then
            XCTAssertFalse(success)
            XCTAssertEqual(error, "Invalid email or password")
        }
    }
    
    // MARK: - User Signup Test Cases
    var signupViewModel: SignupViewModel!
    
    func testUserSignupSuccess() {
        // Given
        let email = "arooj@a.com"
        let password = "1234567"
        let confirmPassword = "1234567"
        let userName = "Arooj"
        guard let btnImage = UIImage(systemName: "checkmark.square") else { return }
        
        // When
        signupViewModel.signUp(email: email, password: password, confirmPassword: confirmPassword, userName: userName, btnImage: btnImage) { success, error in
            
            // Then
            XCTAssertTrue(success)
            XCTAssertNil(error)
        }
        
    }
    
    func testUserSignupFailure() {
        // Given
        let email = "a@a.com" //email already exists
        let password = "1234567"
        let confirmPassword = "1234567"
        let userName = "Arooj"
        guard let btnImage = UIImage(systemName: "checkmark.square") else { return }
        
        // When
        signupViewModel.signUp(email: email, password: password, confirmPassword: confirmPassword, userName: userName, btnImage: btnImage) { success, error in
            
            // Then
            XCTAssertFalse(success)
            XCTAssertEqual(error, "Invalid sign up attempt")
        }
        
    }
    
    // MARK: - HomeViewController Test Cases
    var homeViewModel: HomeViewModel!
    
    func testFetchUserName() {
        homeViewModel.fetchName { name in
            if let name = name {
                XCTAssertFalse(name.isEmpty, "Name should not be empty")
            }
        }
    }
    
    func testFetchRecipes() {
        homeViewModel.loadRecipes { recipes, error in
            if let recipes = recipes {
                XCTAssertFalse(recipes.isEmpty, "Recipes should not be empty")
            }
        }
    }
    
    //MARK: - RecipeDetailViewModelTests
    var recipeDetailViewModel: RecipeDetailViewModel!
    var mockRecipe: Recipe!
    
    func testImg() {
        XCTAssertEqual(recipeDetailViewModel.img, URL(string: "https://www.themealdb.com/images/media/meals/xrttsx1487339558.jpg"))
    }
    
    func testName() {
        XCTAssertEqual(recipeDetailViewModel.name, "Biryani")
    }
    
    func testTime() {
        XCTAssertEqual(recipeDetailViewModel.time, "1 hr")
    }
    
    func testCount() {
        XCTAssertEqual(recipeDetailViewModel.count, 2)
    }
    
    func testIngredient() {
        XCTAssertEqual(recipeDetailViewModel.ingredient, ["Rice": ["https://img.freepik.com/free-photo/top-view-raw-rice-inside-plate-dark-desk_179666-27235.jpg?size=626&ext=jpg&ga=GA1.1.1255960126.1709126803&semt=ais": "1kg"], "Chicken": ["https://www.cookingclarified.com/wp-content/uploads/2010/09/Roast-Cooked-Chicken.jpg": "500g"]])
    }
    
    func testIngredientItem() {
        let riceIngredientItem = recipeDetailViewModel.ingredientItem(at: 0)
        XCTAssertEqual(riceIngredientItem?.0, "Rice")
        XCTAssertEqual(riceIngredientItem?.1, "https://img.freepik.com/free-photo/top-view-raw-rice-inside-plate-dark-desk_179666-27235.jpg?size=626&ext=jpg&ga=GA1.1.1255960126.1709126803&semt=ais")
        XCTAssertEqual(riceIngredientItem?.2, "1kg")
        let chickenIngredientItem = recipeDetailViewModel.ingredientItem(at: 1)
        XCTAssertEqual(chickenIngredientItem?.0, "Chicken")
        XCTAssertEqual(chickenIngredientItem?.1, "https://www.cookingclarified.com/wp-content/uploads/2010/09/Roast-Cooked-Chicken.jpg")
        XCTAssertEqual(chickenIngredientItem?.2, "500g")
        XCTAssertNil(recipeDetailViewModel.ingredientItem(at: 2))
    }
    
    func testProcedureItem() {
        if let procedureItem = recipeDetailViewModel.procedureItem(at: 0) {
            XCTAssertEqual(procedureItem.1, "First fry masala.")
            XCTAssertEqual(procedureItem.0, 1)
        } else {
            XCTFail("Procedure item at index 0 should not be nil")
        }

        XCTAssertNil(recipeDetailViewModel.procedureItem(at: 5))
    }
    
    //MARK: - ProfileViewModel
    var profileViewModel: ProfileViewModel!
    var signOutExpectation: XCTestExpectation!

    func testSignOut() {
        profileViewModel.signOut {
            self.signOutExpectation.fulfill()
        }
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("Sign out timed out: \(error)")
            }
        }
    }
    
}

