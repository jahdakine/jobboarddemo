# == Route Map (Updated 2013-12-17 09:38)
#
#              Prefix Verb   URI Pattern                         Controller#Action
#                root GET    /                                   sessions#new
#              admins GET    /admins(.:format)                   admins#index
#               users GET    /users(.:format)                    users#index
#                     POST   /users(.:format)                    users#create
#            new_user GET    /users/new(.:format)                users#new
#                user DELETE /users/:id(.:format)                users#destroy
#           members GET    /members(.:format)                members#index
#       edit_member GET    /members/:id/edit(.:format)       members#edit
#            member GET    /members/:id(.:format)            members#show
#                     PATCH  /members/:id(.:format)            members#update
#                     PUT    /members/:id(.:format)            members#update
#          employers GET    /employers(.:format)               employers#index
#                     POST   /employers(.:format)               employers#create
#       new_employer GET    /employers/new(.:format)           employers#new
#      edit_employer GET    /employers/:id/edit(.:format)      employers#edit
#           employer GET    /employers/:id(.:format)           employers#show
#                     PATCH  /employers/:id(.:format)           employers#update
#                     PUT    /employers/:id(.:format)           employers#update
#                     DELETE /employers/:id(.:format)           employers#destroy
#            openings GET    /openings(.:format)                 openings#index
#                     POST   /openings(.:format)                 openings#create
#         new_opening GET    /openings/new(.:format)             openings#new
#        edit_opening GET    /openings/:id/edit(.:format)        openings#edit
#             opening GET    /openings/:id(.:format)             openings#show
#                     PATCH  /openings/:id(.:format)             openings#update
#                     PUT    /openings/:id(.:format)             openings#update
#                     DELETE /openings/:id(.:format)             openings#destroy
#           interests GET    /interests(.:format)                interests#index
#                     POST   /interests(.:format)                interests#create
#        new_interest GET    /interests/new(.:format)            interests#new
#       edit_interest GET    /interests/:id/edit(.:format)       interests#edit
#            interest GET    /interests/:id(.:format)            interests#show
#                     PATCH  /interests/:id(.:format)            interests#update
#                     PUT    /interests/:id(.:format)            interests#update
#                     DELETE /interests/:id(.:format)            interests#destroy
#            sessions POST   /sessions(.:format)                 sessions#create
#         new_session GET    /sessions/new(.:format)             sessions#new
#             session DELETE /sessions/:id(.:format)             sessions#destroy
#     password_resets POST   /password_resets(.:format)          password_resets#create
#  new_password_reset GET    /password_resets/new(.:format)      password_resets#new
# edit_password_reset GET    /password_resets/:id/edit(.:format) password_resets#edit
#      password_reset PATCH  /password_resets/:id(.:format)      password_resets#update
#                     PUT    /password_resets/:id(.:format)      password_resets#update
#                     GET    /display/:id(.:format)              employers#display
#               purge GET    /purge(.:format)                    users#purge
#               close GET    /close(.:format)                    openings#close
#               saved GET    /saved(.:format)                    openings#saved
#                     GET    /add_saved/:id(.:format)            openings#add
#                     GET    /remove_saved/:id(.:format)         openings#remove
#               faved GET    /faved(.:format)                    employers#faved
#                     GET    /add_fave/:id(.:format)             employers#add
#                     GET    /remove_fave/:id(.:format)          employers#remove
#               login GET    /login(.:format)                    sessions#new
#            register GET    /register(.:format)                 users#new
#              logout GET    /logout(.:format)                   sessions#destroy
#          contact_us GET    /contact_us(.:format)               docs#contact_us
#      user_agreement GET    /user_agreement(.:format)           docs#user_agreement
#      privacy_policy GET    /privacy_policy(.:format)           docs#privacy_policy
#                     GET    /*path(.:format)                    sessions#destroy
#

JobBoardDemo::Application.routes.draw do
  root :to => 'sessions#new'

  resources :admins, :only => [:index]
  resources :users, only: [:index, :new, :create, :destroy]
  resources :members, only: [:index, :show, :edit, :update]
  resources :employers
  resources :openings
  resources :interests
  resources :sessions, :only => [:new, :create, :destroy]
  resources :password_resets, :only => [:new, :create, :edit, :update]

  match '/display/:id', to: 'employers#display', via: 'get'
  match '/saved', to: 'openings#saved', via: 'get'
  match '/add_saved/:id', to: 'openings#add', via: 'get'
  match '/remove_saved/:id', to: 'openings#remove', via: 'get'
  match '/faved', to: 'employers#faved', via: 'get'
  match '/add_fave/:id', to: 'employers#add', via: 'get'
  match '/remove_fave/:id', to: 'employers#remove', via: 'get'
  match '/purge', to: 'users#purge', via: 'get'
  match '/close', to: 'openings#close', via: 'get'
  match '/login', to: 'sessions#new', via: 'get'
  match '/register', to: 'users#new', via: 'get'
  match '/logout', to: 'sessions#destroy', via: 'get'

  match '/contact_us', to: 'docs#contact_us', via: 'get'
  match '/user_agreement', to: 'docs#user_agreement', via: 'get'
  match '/privacy_policy', to: 'docs#privacy_policy', via: 'get'

  #avoid no route matches exception - careful! if an asset isnt found this is loggin you off!
  match "*path", to: 'sessions#destroy', via: 'get'
end
