import 'dart:io';

import 'package:better_player/better_player.dart';

import '../models/asset.dart';

BetterPlayerConfiguration getPlayerConfiguration() {
  return const BetterPlayerConfiguration(
    autoPlay: true,
    aspectRatio: 16 / 9,
    controlsConfiguration: BetterPlayerControlsConfiguration(
      enablePlayPause: true,
      enableFullscreen: true,
    ),
  );
}

BetterPlayerDataSource getDataSource(Asset asset) {
  return BetterPlayerDataSource(
      BetterPlayerDataSourceType.network, asset.video.getPlaybackURL(),
      drmConfiguration: getDRMConfiguration(asset));
}

BetterPlayerDrmConfiguration? getDRMConfiguration(Asset asset) {
  if (asset.video.drmEnabled) {
    return BetterPlayerDrmConfiguration(
        drmType: Platform.isAndroid
            ? BetterPlayerDrmType.widevine
            : BetterPlayerDrmType.fairplay,
        licenseUrl: asset.licenseURL,
        certificateUrl: asset.certificateURL);
  }
  return null;
}
