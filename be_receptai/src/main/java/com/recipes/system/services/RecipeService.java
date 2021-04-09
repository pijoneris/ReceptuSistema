package com.recipes.system.services;

import com.recipes.system.contracts.QuantityRequest;
import com.recipes.system.contracts.RecipeRequest;
import com.recipes.system.models.ProductModel;
import com.recipes.system.models.RecipeModel;
import com.recipes.system.models.UserModel;
import com.recipes.system.repository.ProductRepository;
import com.recipes.system.repository.RecipeRepository;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

@Service
public class RecipeService {

    private final RecipeRepository recipeRepository;
    private final ProductRepository productRepository;
    private final AuthService authService;

    public RecipeService(RecipeRepository recipeRepository, ProductRepository productRepository, AuthService authService) {
        this.recipeRepository = recipeRepository;
        this.productRepository = productRepository;
        this.authService = authService;
    }

    public void addRecipe(RecipeRequest request){
        UserModel user = authService.getCurrentUser();

        RecipeModel recipeModel = RecipeRequest.fromRecipeRequest(request);
        recipeModel.setUser(user);

        request.getProducts().stream().forEach(it -> {
            ProductModel product = productRepository.findById(it.getProductId()).orElseThrow(()->{
                throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Product does not exists");
            });

            recipeModel.addProductsToRecipe(product, new QuantityRequest(it.getQuantity(), it.getQuantityType()));
        });

        recipeRepository.save(recipeModel);
    }
}
