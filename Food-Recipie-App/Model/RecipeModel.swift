//
//  RecipeModel.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/11/24.
//

import Foundation

enum Category: String {
    case cereal = "Cereal"
    case vegetables = "Vegetables"
    case dinner = "Dinner"
    case chinese = "Chinese"
    case localDish = "Local Dish"
    case Fruit = "Fruit"
    case breakfast = "BreakFast"
    case spanish = "Spanish"
    case lunch = "Lunch"
}

enum Origin: String {
    case all = "All"
    case indain = "Indian"
    case italian = "Italian"
    case asian = "Asian"
    case chinese = "Chinese"
}

struct Recipe: Identifiable {
    let id = UUID()
    let name: String
    let image: String
    let requiredTime: String
    let creator: String
    let publishedDate: String
    let ingredients: [String: [String: String]]
    let category: Category.RawValue
    let procedure: [[String: Any]]
    let rating: Int
    let origin: Origin.RawValue
    let creatorImage: String
    let status: Bool
    
    init?(data: [String: Any]) {
        guard let name = data["name"] as? String,
              let image = data["image"] as? String,
              let requiredTime = data["requiredTime"] as? String,
              let creator = data["creator"] as? String,
              let publishedDate = data["publishedDate"] as? String,
              let ingredients = data["ingredients"] as? [String: [String: String]],
              let category = data["category"] as? String,
              let procedure = data["procedure"] as? [[String: Any]],
              let rating = data["rating"] as? Int,
              let origin = data["origin"] as? String,
              let creatorImage = data["creatorImage"] as? String,
              let status = data["status"] as? Bool
        else {
            return nil
        }
        self.name = name
                self.image = image
                self.requiredTime = requiredTime
                self.creator = creator
                self.publishedDate = publishedDate
                self.ingredients = ingredients
                self.category = category
                self.procedure = procedure
                self.rating = rating
                self.origin = origin
                self.creatorImage = creatorImage
                self.status = status
    }
}

extension Recipe {
    static var all: [Recipe] = [
      //  Recipe(name: "Biryani",
//               image: "https://www.themealdb.com/images/media/meals/xrttsx1487339558.jpg",
//               requiredTime: "1 hr",
//               creator: "Chief John",
//               publishedDate: "2024-3-11",
//               ingredients: ["Rice": ["https://img.freepik.com/free-photo/top-view-raw-rice-inside-plate-dark-desk_179666-27235.jpg?size=626&ext=jpg&ga=GA1.1.1255960126.1709126803&semt=ais": "1kg"],
//                             "Chicken": ["https://www.cookingclarified.com/wp-content/uploads/2010/09/Roast-Cooked-Chicken.jpg": "500g"]],
//               category: "Lunch",
//               procedure: [
//                ["stepDetail": "First fry masala.", "stepNumber": 1],
//                ["stepDetail": "Fry chicken and add water.", "stepNumber": 2],
//                ["stepDetail": "When water boils add Rice.", "stepNumber": 3],
//                ["stepDetail": "Cook until rice absorb water.", "stepNumber": 4],
//                ["stepDetail": "Cook on low flame for 5 to 10 minutes", "stepNumber": 5]
//            ],
//               rating: 4,
//               origin: "Indian",
//               creatorImage: "https://media.gettyimages.com/id/1142230160/photo/beautiful-chef-working-in-a-kitchen-at-a-restaurant.jpg?s=1024x1024&w=gi&k=20&c=Beqs1KDEGnS2Ym567bv5K8JFq2wF8kGwgq-q822WQ7I=", status: false),
//        Recipe(name: "Pasta Carbonara",
//             image: "https://images.services.kitchenstories.io/6glN_4JhpVS9aUiBS7JnGsuDULA=/3840x0/filters:quality(80)/images.kitchenstories.io/wagtailOriginalImages/R2568-photo-final-_0.jpg",
//             requiredTime: "30 mins",
//             creator: "Chef Maria",
//             publishedDate: "2024-3-12",
//             ingredients: ["Spaghetti": ["https://c8.alamy.com/comp/2M6GP0W/bunch-of-raw-spaghetti-2M6GP0W.jpg": "200g"],
//                           "Bacon": ["https://assets.epicurious.com/photos/630386df4eaa77f49a537aa5/4:3/w_4557,h_3418,c_limit/Brown_Sugar_Bacon_RECIPE_081722_38635.jpg": "100g"],
//                           "Eggs": ["https://media.istockphoto.com/id/520889612/photo/boiled-eggs-in-bowl.jpg?s=612x612&w=0&k=20&c=wwes11nnPnZu7IFz6SSSjhsfoBK-ZcTFsqH9Em72ClA=": "2"],
//                           "Parmesan cheese": ["https://www.cheese.com/media/img/cheese/parmesan_on_wooden_surface.jpg": "50g"]],
//             category: Category.dinner.rawValue,
//             procedure: [
//                 ["stepDetail": "Boil spaghetti until al dente.", "stepNumber": 1],
//                 ["stepDetail": "Fry bacon until crispy.", "stepNumber": 2],
//                 ["stepDetail": "Whisk eggs and Parmesan cheese.", "stepNumber": 3],
//                 ["stepDetail": "Mix cooked spaghetti with bacon and egg mixture.", "stepNumber": 4],
//                 ["stepDetail": "Serve hot with extra Parmesan cheese and black pepper.", "stepNumber": 5]
//             ],
//             rating: 5,
//             origin: Origin.italian.rawValue,
//             creatorImage: "https://media.gettyimages.com/id/1142230160/photo/beautiful-chef-working-in-a-kitchen-at-a-restaurant.jpg?s=1024x1024&w=gi&k=20&c=Beqs1KDEGnS2Ym567bv5K8JFq2wF8kGwgq-q822WQ7I=",
//             status: false),
//
//        Recipe(name: "Chicken Tikka Masala",
//             image: "https://bellyfull.net/wp-content/uploads/2021/05/Chicken-Tikka-Masala-blog.jpg",
//             requiredTime: "45 mins",
//             creator: "Chef Ali",
//             publishedDate: "2024-3-13",
//             ingredients: ["Chicken breasts": ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnJvUi03HrVBr98L3mb7AB4UEqjlA9XIFTU_v73r26lw&s": "500g"],
//                           "Yogurt": ["data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD…AV4Cc0qVccz3y+NQAc0qVFAY4cU7OBmlSqgg+lSpVwD//2Q==": "200g"],
//                           "Tomato puree": ["https://www.allrecipes.com/thmb/t1zHxJ6UMwK-JNPLiN…20944-2-2000-561b92f50d4942f18dbe80cafc4b938a.jpg": "400g"],
//                           "Cream": ["data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD…mNvPUMZjMc2TsfL1H7IdU8zQp2ahSq2A1DyGPMZjMQFP/2Q==": "100ml"]],
//             category: Category.dinner.rawValue,
//             procedure: [
//                 ["stepDetail": "Marinate chicken in yogurt and spices.", "stepNumber": 1],
//                 ["stepDetail": "Grill marinated chicken until cooked.", "stepNumber": 2],
//                 ["stepDetail": "Simmer tomato puree with spices.", "stepNumber": 3],
//                 ["stepDetail": "Add grilled chicken to the sauce.", "stepNumber": 4],
//                 ["stepDetail": "Finish with a swirl of cream and serve hot.", "stepNumber": 5]
//             ],
//             rating: 4,
//             origin: Origin.indain.rawValue,
//             creatorImage: "https://media.gettyimages.com/id/1142230160/photo/beautiful-chef-working-in-a-kitchen-at-a-restaurant.jpg?s=1024x1024&w=gi&k=20&c=Beqs1KDEGnS2Ym567bv5K8JFq2wF8kGwgq-q822WQ7I=",
//             status: false),
//
//        Recipe(name: "Pizza",
//             image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSIBvbzfU2Pqd5Fd1-olq1OaX1VXysGuAIgv-y5QPxLrg&s",
//             requiredTime: "30 mins",
//             creator: "Chef Maria",
//             publishedDate: "2024-3-12",
//             ingredients: [
//                "Dough": ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3LVnSQUlcuLB4YrSVQ7TsCkU-0sA4keZuGJHRyZtRhg&s": "500g"],
//                "Tomato Sauce": ["data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD…bwj4RiurqQgRsl6pbggiCLIPXgFd6rbfw8X+QV1dXcRFn/9k=": "200g"],
//                "Cheese": ["data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD…SSQBInRV5cx1J9hSSTAaS7hlLjbpdM1oDAByTJIESSSSQB//Z": "300g"],
//                "Pepperoni": ["data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD…AoBQCgFAKAUAoBQCgFAKAUAoBQCgFAKAUAoBQCgFAKAUB/9k=": "100g"]
//             ],
//             category: Category.dinner.rawValue,
//             procedure: [
//                ["stepDetail": "Prepare the dough.", "stepNumber": 1],
//                ["stepDetail": "Spread tomato sauce on the dough.", "stepNumber": 2],
//                ["stepDetail": "Add cheese and pepperoni.", "stepNumber": 3],
//                ["stepDetail": "Bake in the oven.", "stepNumber": 4],
//                ["stepDetail": "Serve hot.", "stepNumber": 5]
//             ],
//             rating: 5,
//             origin: Origin.italian.rawValue,
//             creatorImage: "https://media.gettyimages.com/id/1142230160/photo/beautiful-chef-working-in-a-kitchen-at-a-restaurant.jpg?s=1024x1024&w=gi&k=20&c=Beqs1KDEGnS2Ym567bv5K8JFq2wF8kGwgq-q822WQ7I=",
//             status: false)


//        Recipe(name: "Biryani", image: "https://www.themealdb.com/images/media/meals/xrttsx1487339558.jpg", requiredTime: "1 hr", creator: "Chief John", publishedDate: "2024-3-11", ingredients: ["Rice": ["https://img.freepik.com/free-photo/top-view-raw-rice-inside-plate-dark-desk_179666-27235.jpg?size=626&ext=jpg&ga=GA1.1.1255960126.1709126803&semt=ais": "1kg"], "Chicken": ["https://www.cookingclarified.com/wp-content/uploads/2010/09/Roast-Cooked-Chicken.jpg": "500g"]], category: "Lunch", procedure: [1: "First fry masala.", 2: "Fry chicken and add water.", 3: "When water boils add Rice.", 4: "Cook until rice absorb water.", 5: "Cook on low flame for 5 to 10 minutes"], rating: 4, origin: "Indian", creatorImage: "https://media.gettyimages.com/id/1142230160/photo/beautiful-chef-working-in-a-kitchen-at-a-restaurant.jpg?s=1024x1024&w=gi&k=20&c=Beqs1KDEGnS2Ym567bv5K8JFq2wF8kGwgq-q822WQ7I="),
//        Recipe(name: "Biryani", image: "https://www.themealdb.com/images/media/meals/xrttsx1487339558.jpg", requiredTime: "1 hr", creator: "Chief John", publishedDate: "2024-3-11", ingredients: ["Rice": ["https://img.freepik.com/free-photo/top-view-raw-rice-inside-plate-dark-desk_179666-27235.jpg?size=626&ext=jpg&ga=GA1.1.1255960126.1709126803&semt=ais": "1kg"], "Chicken": ["https://www.cookingclarified.com/wp-content/uploads/2010/09/Roast-Cooked-Chicken.jpg": "500g"]], category: "BreakFast", procedure: [1: "First fry masala.", 2: "Fry chicken and add water.", 3: "When water boils add Rice.", 4: "Cook until rice absorb water.", 5: "Cook on low flame for 5 to 10 minutes"], rating: 4, origin: "Italian", creatorImage: "https://media.gettyimages.com/id/1142230160/photo/beautiful-chef-working-in-a-kitchen-at-a-restaurant.jpg?s=1024x1024&w=gi&k=20&c=Beqs1KDEGnS2Ym567bv5K8JFq2wF8kGwgq-q822WQ7I="),
//        Recipe(name: "Biryani", image: "https://www.themealdb.com/images/media/meals/xrttsx1487339558.jpg", requiredTime: "1 hr", creator: "Chief John", publishedDate: "2024-3-11", ingredients: ["Rice": ["https://img.freepik.com/free-photo/top-view-raw-rice-inside-plate-dark-desk_179666-27235.jpg?size=626&ext=jpg&ga=GA1.1.1255960126.1709126803&semt=ais": "1kg"], "Chicken": ["https://www.cookingclarified.com/wp-content/uploads/2010/09/Roast-Cooked-Chicken.jpg": "500g"]], category: "Dinner", procedure: [1: "First fry masala.", 2: "Fry chicken and add water.", 3: "When water boils add Rice.", 4: "Cook until rice absorb water.", 5: "Cook on low flame for 5 to 10 minutes"], rating: 4, origin: "Chinese", creatorImage: "https://media.gettyimages.com/id/1142230160/photo/beautiful-chef-working-in-a-kitchen-at-a-restaurant.jpg?s=1024x1024&w=gi&k=20&c=Beqs1KDEGnS2Ym567bv5K8JFq2wF8kGwgq-q822WQ7I="),
//        Recipe(name: "Biryani", image: "https://www.themealdb.com/images/media/meals/xrttsx1487339558.jpg", requiredTime: "1 hr", creator: "Chief John", publishedDate: "2024-3-11", ingredients: ["Rice": ["https://img.freepik.com/free-photo/top-view-raw-rice-inside-plate-dark-desk_179666-27235.jpg?size=626&ext=jpg&ga=GA1.1.1255960126.1709126803&semt=ais": "1kg"], "Chicken": ["https://www.cookingclarified.com/wp-content/uploads/2010/09/Roast-Cooked-Chicken.jpg": "500g"]], category: "Local Dish", procedure: [1: "First fry masala.", 2: "Fry chicken and add water.", 3: "When water boils add Rice.", 4: "Cook until rice absorb water.", 5: "Cook on low flame for 5 to 10 minutes"], rating: 4, origin: "Asian", creatorImage: "https://media.gettyimages.com/id/1142230160/photo/beautiful-chef-working-in-a-kitchen-at-a-restaurant.jpg?s=1024x1024&w=gi&k=20&c=Beqs1KDEGnS2Ym567bv5K8JFq2wF8kGwgq-q822WQ7I="),
//        Recipe(name: "Biryani", image: "https://www.themealdb.com/images/media/meals/xrttsx1487339558.jpg", requiredTime: "1 hr", creator: "Chief John", publishedDate: "2024-3-11", ingredients: ["Rice": ["https://img.freepik.com/free-photo/top-view-raw-rice-inside-plate-dark-desk_179666-27235.jpg?size=626&ext=jpg&ga=GA1.1.1255960126.1709126803&semt=ais": "1kg"], "Chicken": ["https://www.cookingclarified.com/wp-content/uploads/2010/09/Roast-Cooked-Chicken.jpg": "500g"]], category: "Local Dish", procedure: [1: "First fry masala.", 2: "Fry chicken and add water.", 3: "When water boils add Rice.", 4: "Cook until rice absorb water.", 5: "Cook on low flame for 5 to 10 minutes"], rating: 4, origin: "Asian", creatorImage: "https://media.gettyimages.com/id/1142230160/photo/beautiful-chef-working-in-a-kitchen-at-a-restaurant.jpg?s=1024x1024&w=gi&k=20&c=Beqs1KDEGnS2Ym567bv5K8JFq2wF8kGwgq-q822WQ7I=")
   ]
}

////Loop through your Recipe.all array and store each recipe in Firestore
//      let db = Firestore.firestore()
//        for recipe in Recipe.all {
//          // Convert the Recipe struct to a dictionary
//          let recipeData: [String: Any] = [
//              "name": recipe.name,
//              "image": recipe.image,
//              "requiredTime": recipe.requiredTime,
//              "creator": recipe.creator,
//              "publishedDate": recipe.publishedDate,
//              "ingredients": recipe.ingredients,
//              "category": recipe.category,
//              "procedure": recipe.procedure,
//              "rating": recipe.rating,
//              "origin": recipe.origin,
//              "creatorImage": recipe.creatorImage,
//              "status": recipe.status,
//          ]
//
//          // Add a new document with a generated ID
//          db.collection("recipes").addDocument(data: recipeData) { error in
//              if let error = error {
//                  print("Error adding document: \(error)")
//              } else {
//                  print("Document added with ID: \(recipe.id)")
//              }
//          }
//      }
