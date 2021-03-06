package com.recipes.system.contracts;

import com.recipes.system.models.AllergenModel;
import lombok.Data;

import java.io.Serializable;

@Data
public class UserAllergenResponse implements Serializable {
    private Long id;
    private String name;
    private AllergenModel.Intensity intensity;

    public UserAllergenResponse(Long id, String name, AllergenModel.Intensity intensity) {
        this.id = id;
        this.name = name;
        this.intensity = intensity;
    }


    public static UserAllergenResponse fromAllergenModel(Long id, String name, AllergenModel.Intensity intensity) {
        return new UserAllergenResponse(id, name, intensity);
    }
}
