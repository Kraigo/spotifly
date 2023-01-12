enum CloudEventType {
  authorizationFailed,
  authorizationSuccess,
}

class CloudEvent {
  final CloudEventType type;
  CloudEvent({required this.type});
}
