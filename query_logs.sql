--v1. Creating the original tables

-- Create the creators table
CREATE TABLE creators (
    creator_id SERIAL PRIMARY KEY,
    clerk_user_id UUID NOT NULL,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    username VARCHAR(255) UNIQUE,
    email_address VARCHAR(255) UNIQUE,
    phone_number VARCHAR(20),
    telegram_id VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    avg_rating DECIMAL(3,2),
    verification_status BOOLEAN DEFAULT FALSE
);


-- Create the portfolio table
CREATE TABLE portfolios (
  portfolio_id SERIAL PRIMARY KEY,
  creator_id INT REFERENCES creators(creator_id) ON DELETE CASCADE,
  link VARCHAR(255)
);


-- Create the skill table

CREATE TABLE skill_table (
    skill_id SERIAL PRIMARY KEY,
    skill_name VARCHAR(255) NOT NULL
);


-- Create the user_skills table (junction table for many-to-many relationship)
CREATE TABLE user_skills (
    user_id UUID NOT NULL,
    skill_id INT NOT NULL,
    PRIMARY KEY (user_id, skill_id),
    FOREIGN KEY (skill_id) REFERENCES skill_table(skill_id)
);


-- Create the customers table
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    clerk_user_id UUID NOT NULL,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
email_address VARCHAR(255) UNIQUE,
    phone_number VARCHAR(20),
    avg_pay_capacity DECIMAL(10,2),
    telegram_id VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Create ENUM types for order states and status
CREATE TYPE order_state AS ENUM ('open', 'closed');
CREATE TYPE order_status AS ENUM ('completed', 'in-progress', 'no action');


--Create orders table
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    state order_state NOT NULL,
    status order_status NOT NULL,    pay NUMERIC,
    title VARCHAR(255),
    job_duration INTERVAL,
    creator_id INT REFERENCES creators(creator_id) ON DELETE SET NULL,
    customer_id INT REFERENCES customers(customer_id) ON DELETE SET NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    job_rating DECIMAL(3,2)
);



-- Create the roles table
CREATE TABLE roles (
    role_id SERIAL PRIMARY KEY,
    role_name VARCHAR(255) NOT NULL UNIQUE,
    can_manage_admins BOOLEAN DEFAULT FALSE,
    can_edit_orders BOOLEAN DEFAULT FALSE,
    can_view_reports BOOLEAN DEFAULT FALSE
);



-- Create the admin table
CREATE TABLE admin (
    admin_id SERIAL PRIMARY KEY,
    clerk_user_id UUID NOT NULL,
    telegram_id VARCHAR(255),
    email VARCHAR(255) NOT NULL UNIQUE,
    role_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (role_id) REFERENCES roles(role_id)
);


