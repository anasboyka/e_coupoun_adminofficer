import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

// const db = admin.firestore();

export const onCreateUser = functions.firestore.document("officers/{userID}").
	onCreate(async (snapshot) => {
		console.log(snapshot.id);
		if (!snapshot.data()!.email || !snapshot.data()!.icNum) {
			console.log("Error");
		} else {
			const data = snapshot.data();
			// const officerId = data!.officerId;
			// const name = data!.name;
			// const phoneNum = data!.phoneNum;
			// const icNum = data!.icNum;
			const email = data!.email;
			const password = data!.icNum;

			const fbUser = await admin.auth().createUser({email: email, password: password, uid: snapshot.id});
			console.log(fbUser.uid);

			// if (fbUser) {
			// 	await db
			// 		.collection("officers")
			// 		.doc(fbUser.uid)
			// 		.set(
			// 			{
			// 				email: email,
			// 				officerId: officerId,
			// 				name: name,
			// 				phoneNum: phoneNum,
			// 				icNum: icNum,
			// 			},
			// 			{merge: true}
			// 		)
			// 		.then((_) => {
			// 			console.log("User Created"
			// 			);
			// 		})
			// 		.catch((err) => {
			// 			console.log(err);
			// 		});
			// }
		}
	}
	);