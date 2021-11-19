Rails.application.routes.draw do

# Home Page
 get("/", { :controller => "users", :action => "index" })

# Read Page
 get("/pdf_miner", { :controller => "users", :action => "index" })
 post("/upload", { :controller => "users", :action => "results" })
end
