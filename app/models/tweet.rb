class Tweet < ApplicationRecord
    belongs_to :user
    validates :user_id, presence: true
    validates :content, presence: true, length: { maximum: 140 }
    has_many :tweet_hashtag_relations
    has_many :hashtags, through: :tweet_hashtag_relations


  #DBへのコミット直前に実施する
  after_create do
    tweet = Tweet.find_by(id: self.id)
    hashtags  = self.content.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    tweet.hashtags = []
    hashtags.uniq.map do |hashtag|
      #ハッシュタグは先頭の'#'を外した上で保存
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      tweet.hashtags << tag
    end
  end

  before_update do 
    tweet = Tweet.find_by(id: self.id)
    tweet.hashtags.clear
    hashtags = self.content.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      tweet.hashtags << tag
    end
  end

end