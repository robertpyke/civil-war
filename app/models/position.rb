class Position < ActiveRecord::Base
  attr_accessible :accuracy, :latitude, :longitude

  belongs_to :positionable, :polymorphic => true

end
