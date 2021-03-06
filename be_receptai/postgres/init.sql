CREATE TYPE priceEnum AS ENUM ('cheap', 'average', 'expensive');
CREATE TYPE difficultyEnum AS ENUM ('easy', 'normal', 'difficult');
CREATE TYPE intensityEnum AS ENUM ('weak', 'high');
CREATE TYPE quantityTypeEnum AS ENUM ('sp.', 'g', 'kg', 'l', 'ml');

CREATE TABLE IF NOT EXISTS public.users
(
    id        bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name      varchar NOT NULL,
    email     varchar NOT NULL,
    password  varchar NOT NULL,
    is_blocked boolean default false,
    is_admin   boolean default false
);

CREATE TABLE IF NOT EXISTS public.recipe
(
    id           bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    user_id       bigint,
    title        varchar,
    description  varchar,
    time_required int,
    image_url     varchar,
    price        priceEnum,
    difficulty   difficultyEnum,
    CONSTRAINT fk_userId
        FOREIGN KEY (user_id)
            REFERENCES users (id)
);

CREATE TABLE IF NOT EXISTS public.rating
(
    id        bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    rating    int,
    dateRated date default CURRENT_TIMESTAMP,
    recipe_id  bigint,
    user_id    bigint,
    CONSTRAINT fk_rating_recipeId
        FOREIGN KEY (recipe_id)
            REFERENCES recipe (id),
    CONSTRAINT fk_rating_userId
        FOREIGN KEY (user_id)
            REFERENCES users (id)


);

CREATE TABLE IF NOT EXISTS public.comments
(
    id            bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    comment       int,
    date_commented date default CURRENT_TIMESTAMP,
    recipe_id      bigint,
    user_id        bigint,
    CONSTRAINT fk_comments_recipeId
        FOREIGN KEY (recipe_id)
            REFERENCES recipe (id),
    CONSTRAINT fk_comments_userId
        FOREIGN KEY (user_id)
            REFERENCES users (id)


);

CREATE TABLE IF NOT EXISTS public.likes
(
    id        bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    date_liked date default CURRENT_TIMESTAMP,
    recipe_id  bigint,
    user_id    bigint,
    CONSTRAINT fk_likes_recipeId
        FOREIGN KEY (recipe_id)
            REFERENCES recipe (id),
    CONSTRAINT fk_likes_userId
        FOREIGN KEY (user_id)
            REFERENCES users (id)


);

CREATE TABLE IF NOT EXISTS public.product_category
(
    id   bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name varchar
);


CREATE TABLE IF NOT EXISTS public.product
(
    id                bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    product_category_id bigint,
    name              varchar,
    CONSTRAINT fk_productCategoryId
        FOREIGN KEY (product_category_id)
            REFERENCES product_category (id)
);

CREATE TABLE IF NOT EXISTS public.recipe_product
(
    product_id    bigint,
    recipe_id     bigint,
    quantity     int,
    quantity_type quantityTypeEnum,
    CONSTRAINT fk_recipe_product_productId
        FOREIGN KEY (product_id)
            REFERENCES product (id),
    CONSTRAINT fk_recipe_product_recipeId
        FOREIGN KEY (recipe_id)
            REFERENCES recipe (id)


);


CREATE TABLE IF NOT EXISTS public.habit
(
    id   bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name varchar

);

CREATE TABLE IF NOT EXISTS public.habit_product_category
(
    id                bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    habit_id           bigint,
    product_category_id bigint,
    CONSTRAINT fk_habit_product_category_habitId
        FOREIGN KEY (habit_id)
            REFERENCES habit (id),
    CONSTRAINT fk_habit_product_category_productCategoryId
        FOREIGN KEY (product_category_id)
            REFERENCES product_category (id)


);




CREATE TABLE IF NOT EXISTS public.allergene
(
    id        bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name      varchar
);

CREATE TABLE IF NOT EXISTS public.product_allergene
(
    id          bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    product_id   bigint,
    allergene_id bigint,
    CONSTRAINT fk_product_allergene_productId
        FOREIGN KEY (product_id)
            REFERENCES product (id),
    CONSTRAINT fk_product_allergene_alergeneId
        FOREIGN KEY (allergene_id)
            REFERENCES allergene (id)
);



CREATE TABLE IF NOT EXISTS public.user_products
(
    id           bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    quantity     int,
    quantity_type quantityTypeEnum,
    product_id    bigint,
    user_id       bigint,
    CONSTRAINT fk_user_products_productId
        FOREIGN KEY (product_id)
            REFERENCES product (id),
    CONSTRAINT fk_user_products_userId
        FOREIGN KEY (user_id)
            REFERENCES users (id)


);

CREATE TABLE IF NOT EXISTS public.user_allergene
(
    id          bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    allergene_id bigint,
    user_id      bigint,
    intensity intensityEnum,
    CONSTRAINT fk_user_allergene_productId
        FOREIGN KEY (allergene_id)
            REFERENCES allergene (id),
    CONSTRAINT fk_user_allergene_userId
        FOREIGN KEY (user_id)
            REFERENCES users (id)
);

CREATE TABLE IF NOT EXISTS public.user_habits
(
    id      bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    habit_id bigint,
    user_id  bigint,
    CONSTRAINT fk_user_habits_habitID
        FOREIGN KEY (habit_id)
            REFERENCES habit (id),
    CONSTRAINT fk_user_habits_userId
        FOREIGN KEY (user_id)
            REFERENCES users (id)

)


