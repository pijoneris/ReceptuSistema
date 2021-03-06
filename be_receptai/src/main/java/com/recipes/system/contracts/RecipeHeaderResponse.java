package com.recipes.system.contracts;

import com.recipes.system.models.RecipeModel;
import lombok.Data;

@Data
public class RecipeHeaderResponse {
    private Long id;
    private String title;
    private String description;
    private String imageUrl;
    private RecipeModel.Price price;
    private RecipeModel.Difficulty difficulty;

    public RecipeHeaderResponse(String title, String description, String imageUrl, RecipeModel.Price price, RecipeModel.Difficulty difficulty, Long id) {
        this.title = title;
        this.description = description;
        this.imageUrl = imageUrl;
        this.price = price;
        this.difficulty = difficulty;
        this.id = id;
    }

    public RecipeHeaderResponse(){

    }
}
