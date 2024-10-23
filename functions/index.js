const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.checkDueTasks = functions.pubsub.schedule('every 1 hour').onRun(async (context) => {
    const now = new Date();
    const dueDate = new Date(now.getTime() + 24 * 60 * 60 * 1000); // 24 часа вперед

    const tasksSnapshot = await admin.firestore().collection('tasks')
        .where('deadline', '<=', dueDate)
        .get();

    tasksSnapshot.forEach(async (taskDoc) => {
        const task = taskDoc.data();
        const userId = task.userId; // Предполагается, что вы храните идентификатор пользователя

        // Получите токены устройства пользователя
        const userDoc = await admin.firestore().collection('users').doc(userId).get();
        const tokens = userDoc.data().tokens;

        const payload = {
            notification: {
                title: 'Приближающийся срок выполнения задачи',
                body: `Задача "${task.title}" должна быть выполнена до ${task.deadline.toDate()}.`,
            },
        };

        // Отправка уведомлений
        if (tokens) {
            await admin.messaging().sendToDevice(tokens, payload);
        }
    });
});