Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :institutions, :students, :enrollments, :invoices, only: %i[show index create destroy]

      get '/students/:student_id/enrollments', to: 'enrollments#by_student'

      get 'institutions/:institution_id/enrollments', to: 'enrollments#by_institution'

      get '/students/:student_id/invoices', to: 'invoices#by_student'

      get 'institutions/:institution_id/invoices', to: 'invoices#by_institution'
    end
  end
end
