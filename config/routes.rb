Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :institutions, :students, :enrollments, only: %i[show index create destroy]

      get '/students/:student_id/enrollments', to: 'enrollments#by_student'

      get 'institutions/:institution_id/enrollments', to: 'enrollments#by_institution'
    end
  end
end
