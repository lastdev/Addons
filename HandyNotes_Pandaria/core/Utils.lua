local _, addon = ...;

function addon.isPandariaTimerunning ()
  return (
    _G.PlayerGetTimerunningSeasonID and
    _G.PlayerGetTimerunningSeasonID() == _G.Constants.TimerunningConsts.TIMERUNNING_SEASON_PANDARIA
  );
end
