import 'package:equatable/src/equatable_utils.dart';
class CustomEquatable implements CustomEquitableI  {
  /// {@macro equatable}
  const CustomEquatable({
    required this.props
  });

  @override
  final  List  props;



  bool getOperator(Object? other,) =>
      identical(this, other) ||
          other is CustomEquitableI &&
          runtimeType == other.runtimeType &&
              equals(props , other.props);



  @override
  int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode(props);



}

abstract class CustomEquitableI {

  final  List  props;


  /// {@macro equatable}
  const CustomEquitableI({
    required this.props
  });


}


