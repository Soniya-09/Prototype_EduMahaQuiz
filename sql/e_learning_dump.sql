-- e_learning_dump.sql
-- SQL dump for Maharashtra State Board E-Learning Website

-- First, disable foreign key checks
SET FOREIGN_KEY_CHECKS = 0;

-- Drop all tables
DROP TABLE IF EXISTS results;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS students;

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;

-- Create students table
CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create questions table
CREATE TABLE questions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    standard INT NOT NULL,
    question TEXT NOT NULL,
    option_a VARCHAR(255) NOT NULL,
    option_b VARCHAR(255) NOT NULL,
    option_c VARCHAR(255) NOT NULL,
    option_d VARCHAR(255) NOT NULL,
    correct_option CHAR(1) NOT NULL
);

-- Create results table
CREATE TABLE results (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    standard INT NOT NULL,
    score INT NOT NULL,
    percentage FLOAT NOT NULL,
    remark VARCHAR(50) NOT NULL,
    taken_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(id)
);

-- Insert sample students
INSERT INTO students (name, email, password) VALUES
('Test Student', 'student1@example.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi');

-- Insert sample questions for Standard 1
INSERT INTO questions (standard, question, option_a, option_b, option_c, option_d, correct_option) VALUES
(1, 'What is the color of the sky?', 'Blue', 'Green', 'Red', 'Yellow', 'A'),
(1, 'How many days are there in a week?', '5', '6', '7', '8', 'C'),
(1, 'Which animal says "Meow"?', 'Dog', 'Cat', 'Cow', 'Lion', 'B'),
(1, 'What do we drink?', 'Water', 'Sand', 'Stone', 'Wood', 'A'),
(1, 'Which is a fruit?', 'Potato', 'Carrot', 'Apple', 'Onion', 'C'),
(1, 'What comes after 2?', '1', '3', '4', '5', 'B'),
(1, 'Which is a vehicle?', 'Chair', 'Table', 'Car', 'Spoon', 'C'),
(1, 'What is 1 + 1?', '1', '2', '3', '4', 'B'),
(1, 'Which is hot?', 'Ice', 'Fire', 'Water', 'Snow', 'B'),
(1, 'What do we use to write?', 'Pen', 'Spoon', 'Plate', 'Cup', 'A');

-- Insert sample questions for Standard 2
INSERT INTO questions (standard, question, option_a, option_b, option_c, option_d, correct_option) VALUES
(2, 'Which is the largest animal?', 'Dog', 'Cat', 'Elephant', 'Goat', 'C'),
(2, 'What is the capital of Maharashtra?', 'Delhi', 'Mumbai', 'Pune', 'Nagpur', 'B'),
(2, 'How many months are there in a year?', '10', '11', '12', '13', 'C'),
(2, 'Which is a bird?', 'Lion', 'Tiger', 'Sparrow', 'Wolf', 'C'),
(2, 'What is 2 + 2?', '2', '3', '4', '5', 'C'),
(2, 'Which is a vegetable?', 'Banana', 'Apple', 'Potato', 'Mango', 'C'),
(2, 'What do we wear on our feet?', 'Shirt', 'Shoes', 'Hat', 'Gloves', 'B'),
(2, 'Which is a festival?', 'Diwali', 'Monday', 'January', 'Rain', 'A'),
(2, 'What is the color of grass?', 'Red', 'Blue', 'Green', 'Yellow', 'C'),
(2, 'Which is a domestic animal?', 'Lion', 'Tiger', 'Cow', 'Wolf', 'C');

-- Insert sample questions for Standard 3
INSERT INTO questions (standard, question, option_a, option_b, option_c, option_d, correct_option) VALUES
(3, 'Which planet do we live on?', 'Mars', 'Venus', 'Earth', 'Jupiter', 'C'),
(3, 'Who is the father of our nation?', 'Jawaharlal Nehru', 'Mahatma Gandhi', 'Subhash Chandra Bose', 'Bhagat Singh', 'B'),
(3, 'What is 5 x 2?', '7', '8', '10', '12', 'C'),
(3, 'Which is a wild animal?', 'Dog', 'Cat', 'Lion', 'Cow', 'C'),
(3, 'What do plants need to make food?', 'Sunlight', 'Moonlight', 'Stones', 'Sand', 'A'),
(3, 'Which is a festival of lights?', 'Holi', 'Diwali', 'Christmas', 'Eid', 'B'),
(3, 'What is the boiling point of water?', '50°C', '100°C', '150°C', '200°C', 'B'),
(3, 'Which is a means of transport?', 'Book', 'Bus', 'Pen', 'Chair', 'B'),
(3, 'Who teaches in school?', 'Doctor', 'Teacher', 'Engineer', 'Farmer', 'B'),
(3, 'Which is a healthy food?', 'Chips', 'Burger', 'Fruits', 'Candy', 'C'); 

-- Insert sample questions for Standard 4
INSERT INTO questions (standard, question, option_a, option_b, option_c, option_d, correct_option) VALUES
(4, 'What is the capital of India?', 'Mumbai', 'Delhi', 'Kolkata', 'Chennai', 'B'),
(4, 'Which is the largest continent?', 'Africa', 'Asia', 'Europe', 'Australia', 'B'),
(4, 'What is 12 divided by 3?', '2', '3', '4', '5', 'C'),
(4, 'Which is a renewable source of energy?', 'Coal', 'Petrol', 'Wind', 'Diesel', 'C'),
(4, 'Who wrote the national anthem?', 'Rabindranath Tagore', 'Mahatma Gandhi', 'Jawaharlal Nehru', 'Subhash Chandra Bose', 'A'),
(4, 'Which is a herbivore?', 'Lion', 'Tiger', 'Cow', 'Leopard', 'C'),
(4, 'What do we use to measure temperature?', 'Barometer', 'Thermometer', 'Speedometer', 'Altimeter', 'B'),
(4, 'Which is a festival of colors?', 'Diwali', 'Holi', 'Eid', 'Christmas', 'B'),
(4, 'What is the boiling point of water in Celsius?', '50', '90', '100', '120', 'C'),
(4, 'Which is a means of communication?', 'Bus', 'Train', 'Telephone', 'Car', 'C');

-- Insert sample questions for Standard 5
INSERT INTO questions (standard, question, option_a, option_b, option_c, option_d, correct_option) VALUES
(5, 'Who discovered gravity?', 'Newton', 'Einstein', 'Galileo', 'Edison', 'A'),
(5, 'Which is the longest river in the world?', 'Ganga', 'Amazon', 'Nile', 'Yangtze', 'C'),
(5, 'What is the chemical symbol for water?', 'O2', 'H2O', 'CO2', 'NaCl', 'B'),
(5, 'Which planet is known as the Red Planet?', 'Earth', 'Mars', 'Jupiter', 'Saturn', 'B'),
(5, 'Who is known as the Father of Computers?', 'Charles Babbage', 'Bill Gates', 'Steve Jobs', 'Alan Turing', 'A'),
(5, 'Which is a non-metal?', 'Iron', 'Copper', 'Sulphur', 'Silver', 'C'),
(5, 'What is the value of Pi (approx)?', '2.14', '3.14', '4.14', '5.14', 'B'),
(5, 'Which is the largest ocean?', 'Atlantic', 'Indian', 'Arctic', 'Pacific', 'D'),
(5, 'Who wrote "Panchatantra"?', 'Vishnu Sharma', 'Kalidas', 'Tulsidas', 'Valmiki', 'A'),
(5, 'Which vitamin is obtained from sunlight?', 'A', 'B', 'C', 'D', 'D');

-- Insert sample questions for Standard 6
INSERT INTO questions (standard, question, option_a, option_b, option_c, option_d, correct_option) VALUES
(6, 'What is the powerhouse of the cell?', 'Nucleus', 'Ribosome', 'Mitochondria', 'Chloroplast', 'C'),
(6, 'Which is the hardest natural substance?', 'Gold', 'Iron', 'Diamond', 'Platinum', 'C'),
(6, 'What is the boiling point of water?', '0°C', '50°C', '100°C', '200°C', 'C'),
(6, 'Who invented the light bulb?', 'Edison', 'Newton', 'Einstein', 'Tesla', 'A'),
(6, 'What is the capital of India?', 'Mumbai', 'Chennai', 'New Delhi', 'Kolkata', 'C'),
(6, 'Which gas do plants use for photosynthesis?', 'Oxygen', 'Carbon Dioxide', 'Nitrogen', 'Hydrogen', 'B'),
(6, 'Which metal is liquid at room temperature?', 'Iron', 'Mercury', 'Copper', 'Aluminum', 'B'),
(6, 'Who was the first President of India?', 'Jawaharlal Nehru', 'B. R. Ambedkar', 'Rajendra Prasad', 'Sardar Patel', 'C'),
(6, 'What is 15 x 6?', '90', '80', '75', '95', 'A'),
(6, 'Which is the smallest planet in our solar system?', 'Earth', 'Mars', 'Venus', 'Mercury', 'D');


-- Insert sample questions for Standard 7
INSERT INTO questions (standard, question, option_a, option_b, option_c, option_d, correct_option) VALUES
(7, 'Which part of the plant conducts photosynthesis?', 'Root', 'Stem', 'Leaf', 'Flower', 'C'),
(7, 'What is the SI unit of force?', 'Newton', 'Watt', 'Joule', 'Pascal', 'A'),
(7, 'Which organ helps in purification of blood?', 'Lungs', 'Liver', 'Heart', 'Kidney', 'D'),
(7, 'Which is a renewable source of energy?', 'Coal', 'Petrol', 'Wind', 'Diesel', 'C'),
(7, 'What is the chemical formula of salt?', 'H2O', 'CO2', 'NaCl', 'O2', 'C'),
(7, 'Who invented the telephone?', 'Newton', 'Edison', 'Alexander Graham Bell', 'Tesla', 'C'),
(7, 'Which is the nearest star to Earth?', 'Sirius', 'Sun', 'Alpha Centauri', 'Polaris', 'B'),
(7, 'Which is the national bird of India?', 'Crow', 'Peacock', 'Sparrow', 'Parrot', 'B'),
(7, 'What is the square root of 81?', '7', '8', '9', '6', 'C'),
(7, 'Who wrote the Mahabharata?', 'Valmiki', 'Ved Vyasa', 'Kalidas', 'Tulsidas', 'B');


-- Insert sample questions for Standard 8
INSERT INTO questions (standard, question, option_a, option_b, option_c, option_d, correct_option) VALUES
(8, 'Which gas is known as laughing gas?', 'Nitrogen', 'Nitrous oxide', 'Oxygen', 'Carbon dioxide', 'B'),
(8, 'What is the atomic number of oxygen?', '6', '7', '8', '9', 'C'),
(8, 'Who discovered penicillin?', 'Newton', 'Alexander Fleming', 'Einstein', 'Curie', 'B'),
(8, 'Which state is known as the Land of Five Rivers?', 'Maharashtra', 'Punjab', 'Bihar', 'Odisha', 'B'),
(8, 'Which blood group is universal donor?', 'A', 'B', 'AB', 'O', 'D'),
(8, 'What is 13 x 7?', '81', '91', '101', '111', 'B'),
(8, 'Which is the largest gland in the human body?', 'Pancreas', 'Liver', 'Thyroid', 'Pituitary', 'B'),
(8, 'Which planet has rings around it?', 'Earth', 'Mars', 'Saturn', 'Jupiter', 'C'),
(8, 'Who wrote "Discovery of India"?', 'Gandhi', 'Nehru', 'Tagore', 'Ambedkar', 'B'),
(8, 'Which layer protects Earth from UV rays?', 'Troposphere', 'Stratosphere', 'Ozone Layer', 'Lithosphere', 'C');


-- Insert sample questions for Standard 9
INSERT INTO questions (standard, question, option_a, option_b, option_c, option_d, correct_option) VALUES
(9, 'What is the formula of speed?', 'Distance × Time', 'Distance / Time', 'Time / Distance', 'Force / Area', 'B'),
(9, 'Who proposed the laws of motion?', 'Newton', 'Einstein', 'Galileo', 'Faraday', 'A'),
(9, 'What is the pH value of pure water?', '5', '6', '7', '8', 'C'),
(9, 'Which is the largest desert in the world?', 'Sahara', 'Thar', 'Arctic', 'Gobi', 'A'),
(9, 'Who was the first woman Prime Minister of India?', 'Sushma Swaraj', 'Pratibha Patil', 'Indira Gandhi', 'Sarojini Naidu', 'C'),
(9, 'Which is a scalar quantity?', 'Force', 'Velocity', 'Speed', 'Momentum', 'C'),
(9, 'How many chromosomes do humans have?', '23', '46', '48', '24', 'B'),
(9, 'Which law explains buoyant force?', 'Newton’s Law', 'Archimedes’ Principle', 'Pascal’s Law', 'Hooke’s Law', 'B'),
(9, 'What is the capital of Japan?', 'Beijing', 'Seoul', 'Tokyo', 'Bangkok', 'C'),
(9, 'Which element is used in electric bulbs?', 'Copper', 'Iron', 'Tungsten', 'Zinc', 'C');


-- Insert sample questions for Standard 10
INSERT INTO questions (standard, question, option_a, option_b, option_c, option_d, correct_option) VALUES
(10, 'Which acid is present in lemon?', 'Hydrochloric acid', 'Sulfuric acid', 'Citric acid', 'Acetic acid', 'C'),
(10, 'Who discovered the electron?', 'Thomson', 'Rutherford', 'Bohr', 'Chadwick', 'A'),
(10, 'What is the SI unit of electric current?', 'Volt', 'Ampere', 'Ohm', 'Watt', 'B'),
(10, 'What is the focal length of a plane mirror?', 'Zero', 'Infinite', '10 cm', '5 cm', 'B'),
(10, 'Which state has the highest literacy rate?', 'Bihar', 'Kerala', 'Maharashtra', 'Tamil Nadu', 'B'),
(10, 'What is the chemical name of common salt?', 'Sodium Carbonate', 'Sodium Chloride', 'Calcium Carbonate', 'Potassium Iodide', 'B'),
(10, 'Who wrote the Constitution of India?', 'Nehru', 'Gandhi', 'Ambedkar', 'Rajendra Prasad', 'C'),
(10, 'What is the unit of work?', 'Joule', 'Watt', 'Newton', 'Ampere', 'A'),
(10, 'Which mirror is used in vehicles for rear view?', 'Concave', 'Plane', 'Convex', 'None', 'C'),
(10, 'Which movement did Gandhiji launch in 1942?', 'Non-Cooperation', 'Dandi March', 'Quit India', 'Civil Disobedience', 'C');
