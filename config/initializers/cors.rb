# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:3001'
    # ここで、originを文字列で設定しています。正規表現にマッチするoriginを指定することもできます。

    resource '*', # そして、どのようなHTTPリクエストを許可するのか?をここで設定できます。
                  # 例えばGETだけは許可する、みたいなことがここでは制限できます。今回はいったん全て許可していますが、もし本番環境で必要のないメソッドがあれば追加しなほうが安全です。
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
