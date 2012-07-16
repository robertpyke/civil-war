class Position < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :altitude, :accuracy, :altitudeAccuracy, :heading, :speed

  belongs_to :positionable, :polymorphic => true

end
