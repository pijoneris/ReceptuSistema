package com.recipes.system.contracts;

import lombok.Data;

@Data
public class ProductRequest extends QuantityRequest {
    private Long productId;
}
