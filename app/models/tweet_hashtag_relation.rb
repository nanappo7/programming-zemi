class TweetHashtagRelation < ApplicationRecord
    belongs_to :tweet
    belongs_to :hashtag
    with_options presence: true do
        validates :tweet_id
        validates :hashtag_id
    end
end
