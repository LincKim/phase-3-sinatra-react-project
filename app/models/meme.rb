class Meme < ActiveRecord::Base
    enum :status, [ :CREATED, :ONGOING, :COMPLETED, :CANCELLED ]
end