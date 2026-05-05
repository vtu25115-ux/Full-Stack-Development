const mysql = require('mysql2/promise');

async function testConnection(host, user, password, port) {
    try {
        const pool = mysql.createPool({ host, user, password, port, connectTimeout: 1000 });
        const conn = await pool.getConnection();
        console.log(`✅ Success with port=${port}`);
        conn.release();
        await pool.end();
        return true;
    } catch (err) {
        // If ECONNREFUSED, it means nothing is listening there.
        // If ER_ACCESS_DENIED_ERROR, it means something is listening but credentials failed.
        if (err.code !== 'ECONNREFUSED') {
            console.log(`❌ Failed on port ${port}: ${err.message}`);
        }
        return false;
    }
}

async function run() {
    const ports = [3306, 3307, 3308, 3309, 3310];
    for (const port of ports) {
        const success = await testConnection('127.0.0.1', 'root', 'root123', port);
        if (success) {
            console.log(`\n🎉 Found valid port: DB_PORT=${port}`);
            process.exit(0);
        }
    }
    console.log('\n❌ Could not connect securely on any port with root/root123.');
    process.exit(1);
}

run();
