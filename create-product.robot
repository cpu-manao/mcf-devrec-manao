*** Settings ***

Library    SeleniumLibrary

Suite Setup  Login Merchant Center 
Test Setup  Go To  ${createProduct}
Suite Teardown  Close Browser

***Variables***

${url}  http://mcf-qa-merchant-center.herokuapp.com
${createProduct}  http://mcf-qa-merchant-center.herokuapp.com/products/new
${browser}  chrome

${email}  devrec-manao@mycloudfulfillment.com
${password}  1yt5Gfsd

${name}  Green Shirt
${category}  Cloth
${50character}  The European languages are members of the same fam
${imagePNG32px}  D:\\20220707-RBF-Test\\Image\\green_shirt_32_png.png
${imageJPG32px}  D:\\20220707-RBF-Test\\Image\\green_shirt_32_jpg.jpg
${imagePNG33px}  D:\\20220707-RBF-Test\\Image\\orange_shirt_33_png.png
${imageJPG33px}  D:\\20220707-RBF-Test\\Image\\orange_shirt_33_jpg.jpg

***Keywords***

Login Merchant Center 
  Open Browser  ${url}  ${browser}
  Maximize Browser Window
  Set Selenium Speed  0.3
  Location Should Be  ${url}/users/sign_in
  
  Select Checkbox  id=user_remember_me
  Input Text  id=user_email  ${email}
  Input Password  id=user_password  ${password}
  Unselect Checkbox  id=user_remember_me
  Click Button  name=commit
  Element Should Be Visible  //h2[contains(text(),'Welcome to Merchant Center - QA Assignment')]

***Test Cases ***

Create New Product without Product Name
  Input Text  id=category  ${category}
  Choose File  id=image_blob  ${imagePNG32px}
  Click Button  name=commit
  Element Should Be Visible  //div[contains(text(),"Name can't be blank")]
  Element Should Be Visible  //div[contains(text(),'Name is too short (minimum is 3 characters)')]
  Element Should Be Visible  //div[contains(text(),'Name is invalid')]

Create New Product with only Product Name
  Input Text  id=name  ${name}
  Click Button  name=commit
  Element Should Be Visible  //div[@id='category_error']

Create New Product with space in Product Name
  Input Text  id=name  ${SPACE}${name}
  Input Text  id=category  ${category}
  Choose File  id=image_blob  ${imagePNG32px}
  Click Button  name=commit
  Element Should Contain  //body/div[1]  Your new product is created!
  Element Should Be Visible  //a[contains(text(),'Create another product')]

Create New Product with special character in Product Name
  Input Text  id=name  $%!@&฿ Shirt
  Input Text  id=category  ${category}
  Choose File  id=image_blob  ${imagePNG32px}
  Click Button  name=commit
  Element Should Be Visible  //div[contains(text(),'Name is invalid')]

Create New Product with number in Product Name
  Input Text  id=name  072022 Shirt
  Input Text  id=category  ${category}
  Choose File  id=image_blob  ${imagePNG32px}
  Click Button  name=commit
  Element Should Contain  //body/div[1]  Your new product is created!
  Element Should Be Visible  //a[contains(text(),'Create another product')]

Create New Product with less than 3 character in Product Name
  Input Text  id=name  TT
  Input Text  id=category  ${category}
  Choose File  id=image_blob  ${imagePNG32px}
  Click Button  name=commit
  Element Should Be Visible  //div[contains(text(),'Name is too short (minimum is 3 characters)')]

Create New Product with more than 12 character in Product Name
  Input Text  id=name  Green TShirts
  Input Text  id=category  ${category}
  Choose File  id=image_blob  ${imagePNG32px}
  Click Button  name=commit
  Element Should Be Visible  //div[contains(text(),'Name is too long (maximum is 12 characters)')]

# ------------------------------------------------------------------------

Create New Product without Category
  Input Text  id=name  ${name}
  Choose File  id=image_blob  ${imagePNG32px}
  Click Button  name=commit
  Element Should Be Visible  //div[@id='category_error']

Create New Product with only Category
  Input Text  id=category  ${category}
  Click Button  name=commit

Create New Product with space in Category
  Input Text  id=name  ${name}
  Input Text  id=category  ${SPACE}${category}${SPACE}
  Choose File  id=image_blob  ${imagePNG32px}
  Click Button  name=commit
  Element Should Contain  //body/div[1]  Your new product is created!
  Element Should Be Visible  //a[contains(text(),'Create another product')]

Create New Product with special character in Category
  Input Text  id=name  ${name}
  Input Text  id=category  $%!@&฿${category}
  Choose File  id=image_blob  ${imagePNG32px}
  Click Button  name=commit
  Element Should Contain  //body/div[1]  Your new product is created!
  Element Should Be Visible  //a[contains(text(),'Create another product')]

Create New Product with number in Category
  Input Text  id=name  ${name}
  Input Text  id=category  20220707${category}
  Choose File  id=image_blob  ${imagePNG32px}
  Click Button  name=commit
  Element Should Contain  //body/div[1]  Your new product is created!
  Element Should Be Visible  //a[contains(text(),'Create another product')]

Create New Product with 50 character in Category
  Input Text  id=name  ${name}
  Input Text  id=category  ${50character}
  Choose File  id=image_blob  ${imagePNG32px}
  Click Button  name=commit
  Element Should Contain  //body/div[1]  Your new product is created!
  Element Should Be Visible  //a[contains(text(),'Create another product')]

Create New Product with more than 1 Category and separate by comma
  Input Text  id=name  ${name}
  Input Text  id=category  ${category},Casual Wear
  Choose File  id=image_blob  ${imagePNG32px}
  Click Button  name=commit
  Element Should Contain  //body/div[1]  Your new product is created!
  Element Should Be Visible  //a[contains(text(),'Create another product')]

# ------------------------------------------------------------------------

Create New Product without Product Image
  Input Text  id=name  ${name}
  Input Text  id=category  ${category}
  Click Button  name=commit
  Element Should Contain  //body/div[1]  Your new product is created!
  Element Should Be Visible  //a[contains(text(),'Create another product')]

Create New Product with only Product Image
  Choose File  id=image_blob  ${imagePNG32px}
  Click Button  name=commit
  Element Should Be Visible  //div[@id='category_error']

Create New Product with invalid Product Image format
  Input Text  id=name  ${name}
  Input Text  id=category  ${category}
  Choose File  id=image_blob  ${imageJPG32px}
  Click Button  name=commit
  Element Should Be Visible  //div[@id='extension_error']

Create New Product with invalid Product Image size
  Input Text  id=name  ${name}
  Input Text  id=category  ${category}
  Choose File  id=image_blob  ${imagePNG33px}
  Click Button  name=commit
  Element Should Be Visible  //div[@id='image_error']

Create New Product with invalid Product Image format and size
  Input Text  id=name  ${name}
  Input Text  id=category  ${category}
  Choose File  id=image_blob  ${imageJPG33px}
  Click Button  name=commit
  Element Should Be Visible  //div[@id='image_error']

# ------------------------------------------------------------------------

Create New Product by double click Confirm button
  Input Text  id=name  Double Shirt
  Input Text  id=category  ${category}
  Choose File  id=image_blob  ${imagePNG32px}
  Double Click Element  name=commit
  Element Should Contain  //body/div[1]  Your new product is created!
  Element Should Be Visible  //a[contains(text(),'Create another product')]

# ------------------------------------------------------------------------

Create New Product Successfully
  Input Text  id=name  ${name}
  Input Text  id=category  ${category}
  Choose File  id=image_blob  ${imagePNG32px}
  Click Button  name=commit
  Element Should Contain  //body/div[1]  Your new product is created!
  Element Should Be Visible  //a[contains(text(),'Create another product')]
  