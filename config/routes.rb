Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  root 'static_pages#index'
  get 'tradsim' =>         'vocabs#tradsim'
  get 'pinyin1' =>         'vocabs#pinyin1'
  get 'pinyin2' =>         'vocabs#pinyin2'
  get 'googtrans' =>       'vocabs#googtrans'
  get 'segment1' =>         'vocabs#segment1'
  get 'segment2' =>         'vocabs#segment2'
  # get 'engchinesetrad' =>  'vocabs#engchinesetrad'
  # get 'engchinesesimp' =>  'vocabs#engchinesesimp'
  # get 'easytrans' =>       'vocabs#easytrans'
  resources :vocabs, :users
end

