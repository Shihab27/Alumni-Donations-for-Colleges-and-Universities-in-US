# Question 4
attach(alumnigiving_1_)
# Step 1: Load the data into RStudio
# Assuming the data is stored in a data frame named 'alumnigiving'

# Step 2: Use methods of descriptive statistics to summarize the data
summary(alumnigiving_1_)

# (b) Develop an estimated simple linear regression model to predict alumni giving rate based on graduation rate
simple_model <- lm(alumnigiving_1_$`Alumni Giving Rate` ~ alumnigiving_1_$`Graduation Rate`)
simple_model
summary(simple_model)

# (c) Develop an estimated multiple linear regression model to predict alumni giving rate based on multiple variables
multiple_model <- lm(alumnigiving_1_$`Graduation Rate` ~ 
                       alumnigiving_1_$`% of Classes Under 20` + alumnigiving_1_$`Student-Faculty Ratio`)
multiple_model

summary(multiple_model)

# (d) Consider if another regression model may be more appropriate
# It's possible that interaction terms or quadratic terms could improve the model
# Let's try adding interaction terms between Graduation Rate and other predictors
interaction_model <- lm(alumnigiving_1_$`Alumni Giving Rate` ~ 
                          alumnigiving_1_$`Graduation Rate` * alumnigiving_1_$`% of Classes Under 20` *
                          alumnigiving_1_$`Student-Faculty Ratio`)
interaction_model 
summary(interaction_model)

# (e) Interpret results
# i. Conclusions and recommendations
# ii. Universities achieving higher alumni giving rate than expected

# Define the multiple linear regression model coefficients
intercept = 80.6965
coef_classes_under_20 = 0.1833
coef_student_faculty_ratio = -0.6818

# Calculate predicted graduation rates
alumnigiving_1_$Predicted_Graduation_Rate = (intercept +
                                               coef_classes_under_20 * alumnigiving_1_$`% of Classes Under 20`+
                                               coef_student_faculty_ratio * alumnigiving_1_$`Student-Faculty Ratio`)
alumnigiving_1_$Predicted_Graduation_Rate
# Calculate residuals
alumnigiving_1_$Residuals = alumnigiving_1_$`Alumni Giving Rate` - alumnigiving_1_$Predicted_Graduation_Rate


# Filter universities with positive residuals (higher-than-expected alumni giving rates)
high_alumni_giving_universities = alumnigiving_1_[alumnigiving_1_$Residuals>0]
high_alumni_giving_universities

# Display universities with positive residuals
print(high_alumni_giving_universities[['University', 'Alumni Giving Rate', 'Predicted_Graduation_Rate', 'Residuals']])


low_alumni_giving_universities = alumnigiving_1_[alumnigiving_1_$Residuals<0]
low_alumni_giving_universities


high_giving_universities <- alumnigiving[which(residuals(multiple_model) > 0), "University"]
# iii. Universities achieving lower alumni giving rate than expected
low_giving_universities <- alumnigiving[which(residuals(multiple_model) < 0), "University"]
# iv. Other independent variables could include endowment size, student satisfaction surveys, etc.

# (f) Summarize and discuss for the executive management team
# Present the findings, conclusions, and recommendations based on the analysis

# Additional analysis and visualization can be performed as needed to support the conclusions and recommendations
