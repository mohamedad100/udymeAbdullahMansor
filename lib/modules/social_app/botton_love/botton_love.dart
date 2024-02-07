import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Initialize Firebase (make sure to call this before runApp)
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }
//
// class LikeButtonState {
//   final bool isLiked;
//
//   LikeButtonState(this.isLiked);
// }
//
// class LikeButtonCubit extends Cubit<LikeButtonState> {
//   LikeButtonCubit() : super(LikeButtonState(false));
//
//   void toggleLikeStatus() async {
//     // Get the current user ID (assuming you have user authentication)
//     String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
//
//     // Assuming you have a 'likes' collection in Firestore
//     CollectionReference likesCollection =
//     FirebaseFirestore.instance.collection('likes');
//
//     // Check if the user has already liked
//     DocumentSnapshot likeDoc = await likesCollection.doc(userId).get();
//
//     if (likeDoc.exists) {
//       // User has liked, so unlike
//       await likesCollection.doc(userId).delete();
//       emit(LikeButtonState(false));
//     } else {
//       // User hasn't liked, so like
//       await likesCollection.doc(userId).set({});
//       emit(LikeButtonState(true));
//     }
//   }
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: BlocProvider(
//         create: (context) => LikeButtonCubit(),
//         child: MyHomePage(),
//       ),
//     );
//   }
// }
//
// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Like Button Example'),
//       ),
//       body: Center(
//         child: BlocBuilder<LikeButtonCubit, LikeButtonState>(
//           builder: (context, state) {
//             return ElevatedButton(
//               onPressed: () {
//                 // Trigger the toggle like status function
//                 context.read<LikeButtonCubit>().toggleLikeStatus();
//               },
//               child: Text(state.isLiked ? 'Unlike' : 'Like'),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
