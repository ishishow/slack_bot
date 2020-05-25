require 'slack-ruby-client'
require 'dotenv'

  Slack.configure do |conf|
    Dotenv.load
    conf.token = ENV["SLACK_TOKEN"]
  end

  # RTM Clientのインスタンス生成
  client = Slack::RealTime::Client.new

  # slackに接続できたときの処理
  client.on :hello do
    puts 'connected!'
    client.message channel: '#work-for_sho-ishikawa', text: 'connected!'
  end

  # ユーザからのメッセージを検知したときの処理
  client.on :message do |data|
    if data['text'].include?('こんにちは')
      client.message channel: data['channel'], text: "Hi!"
    elsif data['text'].include?('かしこい') || data['text'].include?('えらい')
      client.message channel: data['channel'], text: "Thank you!"
    elsif data['text'].include?('おやすみ')
      client.message channel: data['channel'], text: "Good night"
    else
      client.message channel: data['channel'], text: data['text']
    end
  end

  # Bot start
  client.start!
