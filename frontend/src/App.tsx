import { useState } from 'react'
import { login, register, me, getUsers, setToken } from './api'

export default function App() {
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [name, setName] = useState('')
  const [msg, setMsg] = useState('')
  const [users, setUsers] = useState<any[]>([])

  async function doRegister() {
    try {
      const d = await register(email, password, name)
      setToken(d.token)
      setMsg('Registered: ' + JSON.stringify(d.user))
    } catch (e: any) {
      setMsg(e?.response?.data?.error || e.message)
    }
  }

  async function doLogin() {
    try {
      const d = await login(email, password)
      setToken(d.token)
      const u = await me()
      setMsg('Logged in as ' + JSON.stringify(u))
    } catch (e: any) {
      setMsg(e?.response?.data?.error || e.message)
    }
  }

  async function loadUsers() {
    try {
      const d = await getUsers()
      setUsers(d)
    } catch (e: any) {
      setMsg(e?.response?.data?.error || e.message)
    }
  }

  return (
    <div style={{ padding: 24, fontFamily: 'sans-serif' }}>
      <h1>User Management API - React Client</h1>
      <input placeholder="name" value={name} onChange={e => setName(e.target.value)} />
      <input placeholder="email" value={email} onChange={e => setEmail(e.target.value)} />
      <input placeholder="password" type="password" value={password} onChange={e => setPassword(e.target.value)} />
      <div style={{ marginTop: 8 }}>
        <button onClick={doRegister}>Register</button>
        <button onClick={doLogin}>Login</button>
        <button onClick={loadUsers}>Load Users</button>
      </div>
      <pre style={{ marginTop: 12 }}>{msg}</pre>
      <ul>{users.map((u: any) => <li key={u.id}>{u.email} ({u.role})</li>)}</ul>
    </div>
  )
}
