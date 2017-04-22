class Journey

attr_accessor :entry_station_name, :exit_station_name, :entry_station_zone, :exit_station_zone

  PENALTY_FARE = 6

  def initialize
    @entry_station_name
    @exit_station_name
    @entry_station_zone
    @exit_station_zone
  end

  def start_journey(station)
    @entry_station_name = station
  end

#  def in_journey?
  #  !@entry_station_name.nil?
#  end

  def end_journey(station)
    @exit_station_name = station
  end

  def complete_journey?
    @entry_station_name != nil && @exit_station_name != nil
  end

  def fare
    if @entry_station_name.nil? && !@exit_station_name.nil?
      PENALTY_FARE
    elsif @exit_station_name.nil? && !@entry_station_name.nil?
      PENALTY_FARE
    else
      Oystercard::MINIMUM_BALANCE
    end
  end
end
