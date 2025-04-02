abstract class DownloadStates {}

class DownloadInitialState extends DownloadStates {}

class NotDownloadedState extends DownloadStates {
  final int surahId;

  NotDownloadedState(this.surahId);
}

class DownloadedState extends DownloadStates {
  final int surahId;

  DownloadedState(this.surahId);
}

class NetworkErrorState extends DownloadStates {
  NetworkErrorState(this.error);

  final String error;
}

class ServerErrorState extends DownloadStates {
  ServerErrorState(this.error);

  final String error;
}

class StorageErrorState extends DownloadStates {
  StorageErrorState(this.error);

  final String error;
}
