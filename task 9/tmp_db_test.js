const mysql = require('mysql2/promise');

async function testConnection(host, user, password, port) {
    try {
        const pool = mysql.createPool({ host, user, password, port });
        const conn = await pool.getConnection();
        console.log(`✅ Success with host=${host}, user=${user}, password='${password}', port=${port}`);
        conn.release();
        await pool.end();
        return true;
    } catch (err) {
        console.log(`❌ Failed with password='${password}' on ${host}: ${err.message}`);
        return false;
    }
}

async function run() {
    const passwords = ['root123', 'root', 'password', '', '123456', 'root1234'];
    const hosts = ['localhost', '127.0.0.1'];
    for (const host of hosts) {
        for (const pwd of passwords) {
            const success = await testConnection(host, 'root', pwd, 3306);
            if (success) {
                console.log(`\n🎉 Found valid credentials: DB_HOST=${host}, DB_USER=root, DB_PASSWORD=${pwd}`);
                process.exit(0);
            }
        }
    }
    console.log('\n❌ None of the tested passwords worked.');
    process.exit(1);
}

run();
