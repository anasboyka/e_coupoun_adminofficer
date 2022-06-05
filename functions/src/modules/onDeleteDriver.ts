import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

export const onDeleteDriver = functions.firestore.document("drivers/{userID}").
	onDelete(async (snapshot) => {
		const data = snapshot.data();
		console.log(data);
		await admin.auth().deleteUser(snapshot.id);
	}
	);