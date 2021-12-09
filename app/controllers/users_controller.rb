class UsersController < ApplicationController

  def authenticate

    # get the username from params
    un = params.fetch("input_username")
    # get the password from params
    pw = params.fetch("input_password")

    # look up the record from the db matching username
    user = User.where({ :username => un }).at(0)

    # if there's no record, redirect back to sign in form
    if user == nil
      redirect_to("/user_sign_in", { :alert => "No one by that name round these parts" })
    else
    # if there is a record, check to see if password matches
    if user.authenticate(pw)
      session.store(:user_id, user.id)

      redirect_to("/", { :notice => "welcome back, " + user.username + "!"})

    else

      redirect_to("/user_sign_in", { :alert => "Nice try !"})
      
    end
    # if not, redirect to sign in form

    # if so, set the cookie
    # redirect to homepage

  #  render({ :plain => "hi" })
    end
  end

  def toast_cookies
  
    reset_session

    redirect_to("/", { :notice => "See ya later! "})
  end 


  def new_registration_form

    render({ :template => "users/signup_form.html.erb" })
  end

  def new_session_form

    render({ :template => "users/signin_form.html.erb" })
  end
  
  def upload_form

    render({ :template => "users/blank_upload_form.html.erb" })
  end

  def results_display

    # Parameters: {"user_image"=>#<ActionDispatch::Http::UploadedFile:0x00007f48d94ca4e0 @tempfile=#<Tempfile:/tmp/RackMultipart20211119-2046-150e98f.pdf>, @original_filename="Ambe Mata Picture.pdf", @content_type="application/pdf", @headers="Content-Disposition: form-data; name=\"user_image\"; filename=\"Ambe Mata Picture.pdf\"\r\nContent-Type: application/pdf\r\n">}  
    # params.fetch("user_image")

    # Google Vision code  
      require "google/cloud/vision"

      image_annotator = Google::Cloud::Vision::ImageAnnotator.new

      uploaded_data = params.fetch("user_image")

      a_file = File.open(uploaded_data)

      vision_api_results = image_annotator.text_detection({ :image => a_file })

      @responses = vision_api_results.responses

      @first_result = vision_api_results.responses.at(0)

          # CSV Generation
      headers = ["description"]
      csv = CSV.generate(headers: true) do |csv|
        csv << headers
        @first_result.text_annotations.each_with_index do |text_annotation, index| 
         x = text_annotation['description'].to_s
          # text.each do |text|
            row = []
            row.push(x)
            csv << row
      end
    end

    # @parsed_data = JSON.parse(@first_result)

    # .class = Google::Protobuf::RepeatedField
    # JSON.parse("")
    # CSV.parse("")

    filename = "text.csv"
    file_path = Rails.root.join("public", filename)
    # Temporarily saves the csv file in the public folder so it can be downloaded
    File.open(file_path, "w") do |file|
      file.write(csv)
    end
    
    @file_to_download = filename

    render({ :template => "users/final_results_display.html.erb" })
    end
  end