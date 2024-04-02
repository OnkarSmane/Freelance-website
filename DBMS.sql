create database lab;

use lab;
-- Create Admin table
CREATE TABLE Admin (
    admin_id INT PRIMARY KEY,
    admin_name VARCHAR(100),
    email VARCHAR(100),
    phone_number VARCHAR(20),
    user_type VARCHAR(20) -- Added to specify the type of user
);

-- Create Freelancer table
CREATE TABLE Free (
    freelancer_id INT PRIMARY KEY,
    freelancer_name VARCHAR(100),
    admin_id INT,
    email VARCHAR(100),
    phone_number VARCHAR(20),
    date_of_birth DATE,
    FOREIGN KEY (admin_id) REFERENCES Admin(admin_id)
);

-- Create Client table
CREATE TABLE Client (
    client_id INT PRIMARY KEY,
    client_name VARCHAR(100),
    email VARCHAR(100),
    phone_number VARCHAR(20),
    date_of_birth DATE,
    admin_id INT,
    FOREIGN KEY (admin_id) REFERENCES Admin(admin_id)
);

CREATE TABLE Skill (
    skill_id INT PRIMARY KEY,
    skill_name VARCHAR(50),
    description TEXT
);

-- Create Freelanceskill table
CREATE TABLE Freelanceskill (
    freelancer_id INT,
    skill_id INT,
    description TEXT,
    PRIMARY KEY (freelancer_id, skill_id),
    FOREIGN KEY (freelancer_id) REFERENCES Free(freelancer_id),
    FOREIGN KEY (skill_id) REFERENCES Skill(skill_id)
);

-- Create Portfolio table
CREATE TABLE Portfolio (
    portfolio_id INT PRIMARY KEY,
    freelancer_id INT,
    portfolio_name VARCHAR(100),
    portfolio_description TEXT,
    FOREIGN KEY (freelancer_id) REFERENCES Free(freelancer_id)
);

-- Create Category table
CREATE TABLE Category (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100),
    category_description TEXT
);

-- Create Project table
CREATE TABLE Project (
    project_id INT PRIMARY KEY,
    client_id INT,
    category_id INT,
    project_name VARCHAR(100),
    project_description TEXT,
    budget DECIMAL(10, 2),
    deadline DATE,
    FOREIGN KEY (client_id) REFERENCES Client(client_id),
    FOREIGN KEY (category_id) REFERENCES Category(category_id)
);

-- Create Proposal table
CREATE TABLE Proposal (
    proposal_id INT PRIMARY KEY,
    freelancer_id INT,
    project_id INT,
    proposal_details TEXT,
    proposal_date DATE,
    FOREIGN KEY (freelancer_id) REFERENCES Free(freelancer_id),
    FOREIGN KEY (project_id) REFERENCES Project(project_id)
);

-- Create Contract table
CREATE TABLE Contract (
    contract_id INT PRIMARY KEY,
    project_id INT,
    freelancer_id INT,
    client_id INT,
    contract_date DATE,
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (project_id) REFERENCES Project(project_id),
    FOREIGN KEY (freelancer_id) REFERENCES Free(freelancer_id),
    FOREIGN KEY (client_id) REFERENCES Client(client_id)
);

-- Create Payment table
CREATE TABLE Payment (
    payment_id INT PRIMARY KEY,
    freelancer_id INT,
    project_id INT,
    amount DECIMAL(10,2),
    payment_date DATE,
    payment_method VARCHAR(50),
    FOREIGN KEY (freelancer_id) REFERENCES Free(freelancer_id),
    FOREIGN KEY (project_id) REFERENCES Project(project_id)
);

-- Create Review table
CREATE TABLE Review (
    review_id INT PRIMARY KEY,
    client_id INT,
    freelancer_id INT,
    project_id INT,
    review_details TEXT,
    rating INT,
    review_date DATE,
    FOREIGN KEY (client_id) REFERENCES Client(client_id),
    FOREIGN KEY (freelancer_id) REFERENCES Free(freelancer_id),
    FOREIGN KEY (project_id) REFERENCES Project(project_id)
);

-- Create Message table
CREATE TABLE Message (
    message_id INT PRIMARY KEY,
    sender_id INT,
    receiver_id INT,
    message_details TEXT,
    sent_date DATETIME,
    FOREIGN KEY (sender_id) REFERENCES Free(freelancer_id),
    FOREIGN KEY (receiver_id) REFERENCES Client(client_id)
);

-- Create Notification table
CREATE TABLE Notification (
    notification_id INT PRIMARY KEY,
    user_id INT,
    notification_details TEXT,
    notification_date DATETIME,
    is_read BOOLEAN,
    FOREIGN KEY (user_id) REFERENCES Free(freelancer_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Client(client_id) ON DELETE CASCADE
);

-- Create Feedback table
CREATE TABLE Feedback (
    feedback_id INT PRIMARY KEY,
    user_id INT,
    feedback_details TEXT,
    feedback_date DATE,
    FOREIGN KEY (user_id) REFERENCES Free(freelancer_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Client(client_id) ON DELETE CASCADE
);

-- Insert values into Admin table
INSERT INTO Admin (admin_id, admin_name, email, phone_number, user_type) 
VALUES 
(1, 'John Doe', 'john@example.com', '1234567890', 'admin'),
(2, 'Alice Smith', 'alice@example.com', '0987654321', 'admin'),
(3, 'Bob Johnson', 'bob@example.com', '5555555555', 'admin'),
(4, 'Emily Brown', 'emily@example.com', '6666666666', 'admin'),
(5, 'Michael Davis', 'michael@example.com', '7777777777', 'admin'),
(6, 'Sarah Wilson', 'sarah@example.com', '8888888888', 'admin'),
(7, 'David Martinez', 'david@example.com', '9999999999', 'admin'),
(8, 'Jennifer Taylor', 'jennifer@example.com', '1010101010', 'admin'),
(9, 'William Anderson', 'william@example.com', '1212121212', 'admin'),
(10, 'Jessica Rodriguez', 'jessica@example.com', '1313131313', 'admin');

SELECT * FROM Admin;

-- Insert values into Free table
INSERT INTO Free (freelancer_id, freelancer_name, admin_id, email, phone_number, date_of_birth) 
VALUES 
(1, 'Michael Johnson', 1, 'michael.johnson@example.com', '1111111111', '1990-01-01'),
(2, 'Emily Wilson', 2, 'emily.wilson@example.com', '2222222222', '1991-02-02'),
(3, 'David Brown', 3, 'david.brown@example.com', '3333333333', '1992-03-03'),
(4, 'Sarah Taylor', 4, 'sarah.taylor@example.com', '4444444444', '1993-04-04'),
(5, 'Jessica Lee', 5, 'jessica.lee@example.com', '5555555555', '1994-05-05'),
(6, 'John Miller', 6, 'john.miller@example.com', '6666666666', '1995-06-06'),
(7, 'Alice Davis', 7, 'alice.davis@example.com', '7777777777', '1996-07-07'),
(8, 'Bob Clark', 8, 'bob.clark@example.com', '8888888888', '1997-08-08'),
(9, 'Jennifer White', 9, 'jennifer.white@example.com', '9999999999', '1998-09-09'),
(10, 'William Garcia', 10, 'william.garcia@example.com', '1010101010', '1999-10-10');

SELECT * FROM Free;

-- Insert values into Client table
INSERT INTO Client (client_id, client_name, email, phone_number, date_of_birth, admin_id) 
VALUES 
(1, 'Karen Thompson', 'karen@example.com', '1111111111', '1980-01-01', 1),
(2, 'Richard Harris', 'richard@example.com', '2222222222', '1981-02-02', 2),
(3, 'Maria Martinez', 'maria@example.com', '3333333333', '1982-03-03', 3),
(4, 'Christopher Wilson', 'christopher@example.com', '4444444444', '1983-04-04', 4),
(5, 'Linda Garcia', 'linda@example.com', '5555555555', '1984-05-05', 5),
(6, 'Daniel Rodriguez', 'daniel@example.com', '6666666666', '1985-06-06', 6),
(7, 'Patricia Brown', 'patricia@example.com', '7777777777', '1986-07-07', 7),
(8, 'Matthew Lee', 'matthew@example.com', '8888888888', '1987-08-08', 8),
(9, 'Laura Taylor', 'laura@example.com', '9999999999', '1988-09-09', 9),
(10, 'Jason Clark', 'jason@example.com', '1010101010', '1989-10-10', 10);

SELECT * FROM Client;

-- Insert values into Skill table
INSERT INTO Skill (skill_id, skill_name, description) 
VALUES 
(1, 'Web Development', 'Designing and developing websites and web applications'),
(2, 'Graphic Design', 'Creating visual concepts using computer software'),
(3, 'Content Writing', 'Producing written content for various purposes'),
(4, 'Digital Marketing', 'Promoting brands and products through online channels'),
(5, 'Mobile App Development', 'Creating applications for mobile devices'),
(6, 'SEO', 'Improving website visibility and ranking on search engines'),
(7, 'Data Entry', 'Entering data into computer systems or databases'),
(8, 'Translation', 'Converting written text from one language to another'),
(9, 'Video Editing', 'Manipulating and arranging video shots'),
(10, 'Customer Support', 'Providing assistance to customers before, during, or after purchase');

SELECT * FROM Skill;

-- Insert values into Freelanceskill table
INSERT INTO Freelanceskill (freelancer_id, skill_id, description) 
VALUES 
(1, 1, 'Expert in web design and development'),
(1, 2, 'Proficient in HTML, CSS, and JavaScript'),
(2, 3, 'Experienced in graphic design and illustration'),
(2, 4, 'Skilled in Adobe Photoshop and Illustrator'),
(3, 5, 'Professional writer with expertise in content creation'),
(3, 6, 'Knowledgeable in SEO best practices'),
(4, 7, 'Experienced in social media marketing and advertising'),
(4, 8, 'Familiar with Facebook Ads and Google AdWords'),
(5, 9, 'Mobile app development specialist with iOS and Android skills'),
(5, 10, 'Proficient in Swift, Java, and Kotlin');

SELECT * FROM Freelanceskill;


-- Insert values into Portfolio table
INSERT INTO Portfolio (portfolio_id, freelancer_id, portfolio_name, portfolio_description) 
VALUES 
(1, 1, 'Portfolio 1', 'A collection of web development projects'),
(2, 2, 'Portfolio 2', 'Samples of graphic design work'),
(3, 3, 'Portfolio 3', 'Examples of content writing projects'),
(4, 4, 'Portfolio 4', 'Projects related to digital marketing'),
(5, 5, 'Portfolio 5', 'Mobile app development projects'),
(6, 6, 'Portfolio 6', 'SEO optimization examples'),
(7, 7, 'Portfolio 7', 'Data entry projects completed'),
(8, 8, 'Portfolio 8', 'Translations in various languages'),
(9, 9, 'Portfolio 9', 'Video editing samples'),
(10, 10, 'Portfolio 10', 'Customer support experience');

SELECT * FROM Portfolio;

-- Insert values into Category table
INSERT INTO Category (category_id, category_name, category_description) 
VALUES 
(1, 'Web Development', 'Projects related to website and web application development'),
(2, 'Graphic Design', 'Designing visual content for various purposes'),
(3, 'Writing', 'Content creation and writing services'),
(4, 'Marketing', 'Promotional activities and strategies'),
(5, 'Mobile App Development', 'Creating applications for mobile devices'),
(6, 'SEO', 'Search engine optimization services'),
(7, 'Data Entry', 'Entering data into computer systems'),
(8, 'Translation', 'Converting text from one language to another'),
(9, 'Video Editing', 'Editing and enhancing video content'),
(10, 'Customer Support', 'Assistance provided to customers');

SELECT * FROM Category;

-- Insert values into Project table
INSERT INTO Project (project_id, client_id, category_id, project_name, project_description, budget, deadline) 
VALUES 
(1, 1, 1, 'Website Redesign', 'Redesigning company website for better user experience', 5000.00, '2024-05-15'),
(2, 2, 2, 'Logo Design', 'Creating a new logo for a startup company', 1000.00, '2024-06-01'),
(3, 3, 3, 'Article Writing', 'Writing articles for a blog on various topics', 800.00, '2024-05-20'),
(4, 4, 4, 'Social Media Campaign', 'Running a promotional campaign on social media platforms', 2000.00, '2024-06-10'),
(5, 5, 5, 'Mobile App Development', 'Developing a mobile application for a business', 10000.00, '2024-07-01'),
(6, 6, 6, 'SEO Optimization', 'Improving website ranking and visibility on search engines', 1500.00, '2024-05-25'),
(7, 7, 7, 'Data Entry Project', 'Entering data from handwritten forms into digital format', 600.00, '2024-06-05'),
(8, 8, 8, 'Translation Services', 'Translating documents from English to Spanish', 400.00, '2024-05-30'),
(9, 9, 9, 'Video Editing', 'Editing and enhancing promotional video for a company', 1200.00, '2024-06-15'),
(10, 10, 10, 'Customer Support', 'Providing customer support via email and live chat', 800.00, '2024-06-20');

SELECT * FROM Project;

-- Insert values into Proposal table
INSERT INTO Proposal (proposal_id, freelancer_id, project_id, proposal_details, proposal_date) 
VALUES 
(1, 1, 1, 'I have extensive experience in website redesign and can deliver a modern and user-friendly design within the specified budget and timeline.', '2024-04-02'),
(2, 2, 2, 'I specialize in logo design and can create a unique and professional logo that reflects your company\'s identity.', '2024-04-02'),
(3, 3, 3, 'I am a skilled writer capable of producing high-quality articles on a wide range of topics.', '2024-04-02'),
(4, 4, 4, 'I have expertise in running successful social media campaigns and can help increase your brand\'s visibility.', '2024-04-02'),
(5, 5, 5, 'I have developed several mobile applications and can create a customized solution tailored to your business needs.', '2024-04-02'),
(6, 6, 6, 'I specialize in SEO optimization and can improve your website\'s ranking and visibility on search engines.', '2024-04-02'),
(7, 7, 7, 'I am detail-oriented and proficient in data entry tasks, ensuring accurate and efficient completion of projects.', '2024-04-02'),
(8, 8, 8, 'I am fluent in English and Spanish and can provide accurate and reliable translation services.', '2024-04-02'),
(9, 9, 9, 'I have advanced video editing skills and can create visually appealing and engaging content for your company.', '2024-04-02'),
(10, 10, 10, 'I have experience in providing excellent customer support and can assist your customers effectively.', '2024-04-02');

SELECT * FROM Proposal;

-- Insert values into Contract table
INSERT INTO Contract (contract_id, project_id, freelancer_id, client_id, contract_date, start_date, end_date) 
VALUES 
(1, 1, 1, 1, '2024-04-05', '2024-04-10', '2024-05-15'),
(2, 2, 2, 2, '2024-04-05', '2024-04-10', '2024-06-01'),
(3, 3, 3, 3, '2024-04-05', '2024-04-10', '2024-05-20'),
(4, 4, 4, 4, '2024-04-05', '2024-04-10', '2024-06-10'),
(5, 5, 5, 5, '2024-04-05', '2024-04-10', '2024-07-01'),
(6, 6, 6, 6, '2024-04-05', '2024-04-10', '2024-05-25'),
(7, 7, 7, 7, '2024-04-05', '2024-04-10', '2024-06-05'),
(8, 8, 8, 8, '2024-04-05', '2024-04-10', '2024-05-30'),
(9, 9, 9, 9, '2024-04-05', '2024-04-10', '2024-06-15'),
(10, 10, 10, 10, '2024-04-05', '2024-04-10', '2024-06-20');

SELECT * FROM Contract;

-- Insert values into Payment table
INSERT INTO Payment (payment_id, freelancer_id, project_id, amount, payment_date, payment_method) 
VALUES 
(1, 1, 1, 2500.00, '2024-05-10', 'Bank Transfer'),
(2, 2, 2, 1000.00, '2024-06-01', 'PayPal'),
(3, 3, 3, 800.00, '2024-05-20', 'Credit Card'),
(4, 4, 4, 1500.00, '2024-06-10', 'Bank Transfer'),
(5, 5, 5, 5000.00, '2024-07-01', 'PayPal'),
(6, 6, 6, 1200.00, '2024-05-25', 'Credit Card'),
(7, 7, 7, 600.00, '2024-06-05', 'Bank Transfer'),
(8, 8, 8, 400.00, '2024-05-30', 'PayPal'),
(9, 9, 9, 1000.00, '2024-06-15', 'Credit Card'),
(10, 10, 10, 800.00, '2024-06-20', 'Bank Transfer');

SELECT *FROM Payment;

-- Insert values into Review table
INSERT INTO Review (review_id, client_id, freelancer_id, project_id, review_details, rating, review_date) 
VALUES 
(1, 1, 1, 1, 'Michael did an excellent job redesigning our website. Highly recommended!', 5, '2024-05-20'),
(2, 2, 2, 2, 'Emily delivered a fantastic logo design. Very happy with the result!', 5, '2024-06-05'),
(3, 3, 3, 3, 'David provided high-quality articles for our blog. Will hire again!', 4, '2024-05-25'),
(4, 4, 4, 4, 'Sarah ran an effective social media campaign that boosted our brand awareness.', 4, '2024-06-15'),
(5, 5, 5, 5, 'Jessica developed a great mobile app for our business. Impressed with her skills!', 5, '2024-07-05'),
(6, 6, 6, 6, 'John improved our website\'s ranking significantly. Great SEO work!', 4, '2024-05-30'),
(7, 7, 7, 7, 'Alice completed the data entry project accurately and on time. Thank you!', 4, '2024-06-10'),
(8, 8, 8, 8, 'Bob provided accurate translations. Professional and reliable service!', 5, '2024-06-01'),
(9, 9, 9, 9, 'Jennifer edited our promotional video beautifully. Very talented!', 5, '2024-06-20'),
(10, 10, 10, 10, 'William provided excellent customer support. Very responsive and helpful!', 5, '2024-07-10');

SELECT * FROM Review;

-- Insert values into Message table
INSERT INTO Message (message_id, sender_id, receiver_id, message_details, sent_date) 
VALUES 
(1, 1, 2, 'Hi there! I noticed your project and would like to discuss it further.', '2024-04-02 10:00:00'),
(2, 2, 1, 'Hello! Sure, lets talk about it. What specific details would you like to know?', '2024-04-02 10:05:00'),
(3, 3, 1, 'Hi! Im interested in working with you on your project.', '2024-04-02 10:10:00'),
(4, 1, 3, 'Great! Can you please provide more information about your skills and experience?', '2024-04-02 10:15:00'),
(5, 1, 4, 'Hello! I saw your profile and would like to collaborate on a project.', '2024-04-02 10:20:00'),
(6, 4, 1, 'Sure, I had love to work with you. What type of project do you have in mind?', '2024-04-02 10:25:00'),
(7, 2, 3, 'Hi there! I have a new project idea that I think you had be perfect for.', '2024-04-02 10:30:00'),
(8, 3, 2, 'That sounds interesting! Im eager to hear more about it.', '2024-04-02 10:35:00'),
(9, 5, 2, 'Hello! I need your expertise on a mobile app development project.', '2024-04-02 10:40:00'),
(10, 2, 5, 'Sure, Im available to discuss the project details whenever you are ready.', '2024-04-02 10:45:00');

SELECT * FROM Message;

-- Insert values into Notification table
INSERT INTO Notification (notification_id, user_id, notification_details, notification_date, is_read) 
VALUES 
(1, 1, 'You have a new message from User 2.', '2024-04-02 10:00:00', FALSE),
(2, 2, 'New project proposal received.', '2024-04-02 10:05:00', FALSE),
(3, 3, 'Your project proposal has been accepted.', '2024-04-02 10:10:00', FALSE),
(4, 1, 'Payment received for Project X.', '2024-04-02 10:15:00', FALSE),
(5, 4, 'New project proposal received.', '2024-04-02 10:20:00', FALSE),
(6, 5, 'You have a new message from User 2.', '2024-04-02 10:25:00', FALSE),
(7, 2, 'New project proposal received.', '2024-04-02 10:30:00', FALSE),
(8, 3, 'Your project proposal has been accepted.', '2024-04-02 10:35:00', FALSE),
(9, 1, 'Payment received for Project Y.', '2024-04-02 10:40:00', FALSE),
(10, 5, 'New project proposal received.', '2024-04-02 10:45:00', FALSE);

-- Select notifications
SELECT * FROM Notification;

-- Insert values into Feedback table
INSERT INTO Feedback (feedback_id, user_id, feedback_details, feedback_date) 
VALUES 
(1, 1, 'Great work! Highly recommended freelancer.', '2024-04-02'),
(2, 2, 'The project was completed on time with excellent quality.', '2024-04-02'),
(3, 3, 'Good communication and delivered as promised.', '2024-04-02'),
(4, 4, 'Professional and skilled freelancer.', '2024-04-02'),
(5, 5, 'Very satisfied with the work done.', '2024-04-02'),
(6, 1, 'Excellent job! Will hire again for future projects.', '2024-04-02'),
(7, 2, 'Highly impressed with the attention to detail.', '2024-04-02'),
(8, 3, 'Exceeded expectations. Great experience overall.', '2024-04-02'),
(9, 4, 'Very cooperative and responsive freelancer.', '2024-04-02'),
(10, 5, 'Quality work delivered ahead of schedule.', '2024-04-02');

-- Select feedback
SELECT * FROM Feedback;

UPDATE Free
SET email = 'new_email@example.com'
WHERE freelancer_id = 1;

DELETE FROM Client
WHERE client_id = 5;

SELECT c.client_name, p.project_name
FROM Client c
INNER JOIN Project p ON c.client_id = p.client_id;

SELECT * FROM Client
WHERE client_name LIKE '%Smith%';

SELECT MAX(budget) AS max_budget
FROM Project;

SELECT MIN(amount) AS min_payment
FROM Payment;

UPDATE Notification
SET is_read = TRUE
WHERE user_id = 1;

DELETE FROM Feedback
WHERE feedback_id = 3;

SELECT f.freelancer_name, p.portfolio_name
FROM Free f
LEFT JOIN Portfolio p ON f.freelancer_id = p.freelancer_id;

SELECT * FROM Proposal
WHERE freelancer_id = 3 AND project_id = 3;

SELECT COUNT(client_id) AS client_count
FROM Client;

SELECT SUM(amount) AS total_payments
FROM Payment
WHERE freelancer_id = 1;

SELECT AVG(rating) AS avg_rating
FROM Review
WHERE freelancer_id = 2;

UPDATE Project
SET deadline = '2024-07-31'
WHERE project_id = 2;

DELETE FROM Proposal
WHERE freelancer_id = 4;

SELECT c.client_name, r.review_details
FROM Client c
INNER JOIN Review r ON c.client_id = r.client_id;

SELECT * FROM Free
WHERE freelancer_id = 1 OR freelancer_id = 2;

SELECT MAX(notification_date) AS latest_notification_date
FROM Notification;

SELECT MIN(start_date) AS earliest_start_date
FROM Contract;

UPDATE Client
SET phone_number = '1234567890'
WHERE client_id = 3;

DELETE FROM Skill
WHERE skill_id = 7;

SELECT p.project_name, c.category_name
FROM Project p
INNER JOIN Category c ON p.category_id = c.category_id;

SELECT * FROM Free
WHERE admin_id IN (1, 2, 3);

SELECT COUNT(notification_id) AS unread_notifications
FROM Notification
WHERE is_read = FALSE;

SELECT f.freelancer_name, c.contract_date, p.project_name
FROM Free f
INNER JOIN Contract c ON f.freelancer_id = c.freelancer_id
INNER JOIN Project p ON c.project_id = p.project_id;




