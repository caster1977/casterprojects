unit TAPEstimator.uTTableRotation;

interface

type
  TTableRotation = (ttr0, ttr90, ttr180, ttr270);

const
  TABLE_ROTATION_0 = 0;
  TABLE_ROTATION_90 = 90;
  TABLE_ROTATION_180 = 180;
  TABLE_ROTATION_270 = 270;

  TABLE_ROTATIONS: array [low(TTableRotation) .. high(TTableRotation)] of Integer = (TABLE_ROTATION_0, TABLE_ROTATION_90, TABLE_ROTATION_180, TABLE_ROTATION_270);

implementation

end.
