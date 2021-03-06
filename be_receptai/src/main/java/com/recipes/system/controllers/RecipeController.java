package com.recipes.system.controllers;

import com.recipes.system.contracts.*;
import com.recipes.system.models.RecipeModel;
import com.recipes.system.services.RecipeService;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/recipe")
public class RecipeController {

    private final RecipeService recipeService;

    public RecipeController(RecipeService recipeService) {
        this.recipeService = recipeService;
    }

    @GetMapping("/")
    public List<RecipeResponse> getRecipes(@RequestParam(name = "full", defaultValue = "false") boolean full) {
        return recipeService.getRecipes(full);
    }

    @PostMapping("/")
    public void addRecipe(@RequestBody RecipeRequest recipeRequest){
        recipeService.addRecipe(recipeRequest);
    }

    @GetMapping("/{id}")
    public RecipeResponse getRecipe(@PathVariable Long id){
        return recipeService.getRecipe(id);
    }

    @GetMapping("/user")
    public List<RecipeResponse> getUserRecipes(@RequestParam(name = "full", defaultValue = "false") boolean full){
        return recipeService.getUserRecipes(full);
    }

    @PutMapping("/{id}")
    public RecipeResponse updateRecipe(@PathVariable Long id,
                                             @RequestBody RecipeRequest recipeRequest){
        RecipeModel model = recipeService.updateRecipe(id, recipeRequest);
        return RecipeResponse.headerFromRecipeProducts(model);
    }

    @PostMapping("/{id}/products")
    public void addProducts(@PathVariable Long id,
                            @RequestBody List<ProductRecipeRequest> products){
        recipeService.addProducts(id, products);
    }

    @PostMapping("/{id}/products/delete")
    public void removeProducts(@PathVariable Long id,
                            @RequestBody List<Long> productsIds){
        recipeService.removeProducts(id, productsIds);
    }

    @DeleteMapping("/{id}")
    public void deleteRecipe(@PathVariable Long id){
        recipeService.deleteRecipe(id);
    }

    @GetMapping("")
    public RecipePage getRecipePage(
            @RequestParam(name = "page", defaultValue = "0") int page,
            @RequestParam(name = "size", defaultValue = "2") int size,
            @RequestParam(name = "difficulty") Optional<RecipeModel.Difficulty> difficulty,
            @RequestParam(name = "price") Optional<RecipeModel.Price> price) {
        return recipeService.getRecipePage(page, size, difficulty, price);
    }

    @GetMapping("/recommended")
    public RecipePage recommendRecipes() {
        return recipeService.recommendRecipes();
    }
}
