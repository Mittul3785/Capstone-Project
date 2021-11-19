Rails.application.routes.draw do

# Home Page (think of a good name for controller)
 get("/", { :controller => "users", :action => "upload_form" })

# Upload and Results Page
 get("/pdf_miner", { :controller => "users", :action => "upload_form" })
 post("/upload", { :controller => "users", :action => "results_display" })

  # User Signup/Signin/Signout routes

  get("/user_sign_up", {:controller => "users", :action => "new_registration_form"})

  get("/user_sign_out", {:controller => "users", :action => "toast_cookies"})

  get("/user_sign_in", {:controller => "users", :action => "new_session_form"})

  post("/verify_credentials", {:controller => "users", :action => "authenticate"})

end
