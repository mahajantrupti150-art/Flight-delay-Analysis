import Types "../types/flight-data";
import FlightLib "../lib/flight-data";
import List "mo:core/List";

mixin (flights : List.List<FlightLib.FlightRecord>) {

  /// Populate the canister with realistic sample flight records spanning 12 months.
  /// Idempotent: no-op if data already exists.
  public func seedFlightData() : async () {
    if (flights.isEmpty()) {
      FlightLib.seedFlights(flights);
    };
  };

  /// Returns high-level dashboard statistics, optionally filtered.
  public query func getDashboardSummary(filter : Types.FlightFilter) : async Types.DashboardSummary {
    let records = FlightLib.applyFilter(flights, filter);
    FlightLib.computeDashboardSummary(records)
  };

  /// Returns average delay per calendar week (up to 52 points), optionally filtered.
  public query func getDelayTrend(filter : Types.FlightFilter) : async [Types.DelayTrendPoint] {
    let records = FlightLib.applyFilter(flights, filter);
    FlightLib.computeDelayTrend(records)
  };

  /// Returns delay statistics grouped by airline (top 8), optionally filtered.
  public query func getDelaysByAirline(filter : Types.FlightFilter) : async [Types.AirlineDelayStat] {
    let records = FlightLib.applyFilter(flights, filter);
    FlightLib.computeDelaysByAirline(records)
  };

  /// Returns delay statistics grouped by airport (top 8), optionally filtered.
  public query func getDelaysByAirport(filter : Types.FlightFilter) : async [Types.AirportDelayStat] {
    let records = FlightLib.applyFilter(flights, filter);
    FlightLib.computeDelaysByAirport(records)
  };

  /// Returns distribution of flights across delay duration buckets.
  public query func getDelayDistribution(filter : Types.FlightFilter) : async [Types.DelayDistributionBucket] {
    let records = FlightLib.applyFilter(flights, filter);
    FlightLib.computeDelayDistribution(records)
  };

  /// Returns all unique airline codes present in the dataset.
  public query func getAvailableAirlines() : async [Text] {
    FlightLib.getAvailableAirlines(flights)
  };

  /// Returns all unique airport codes present in the dataset.
  public query func getAvailableAirports() : async [Text] {
    FlightLib.getAvailableAirports(flights)
  };
};
