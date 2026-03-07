class RecordTag < ApplicationRecord
  belongs_to :learning_record
  belongs_to :tag
end
