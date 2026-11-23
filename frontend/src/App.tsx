import { useState } from 'react'
import { login, register, me, getUsers, setToken } from './api'

export default function App() {
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [name, setName] = useState('')
  const [msg, setMsg] = useState('')
  const [users, setUsers] = useState<any[]>([])
  const [loading, setLoading] = useState(false)

  async function doRegister() {
    setLoading(true); setMsg('')
    try {
      const d = await register(email, password, name)
      setToken(d.access_token ?? d.token)
      setMsg('Registered: ' + (d.user?.email ?? ''))
    } catch (e: any) {
      setMsg(e?.response?.data?.errors?.join(', ') || e?.response?.data?.error || e.message)
    } finally { setLoading(false) }
  }

  async function doLogin() {
    setLoading(true); setMsg('')
    try {
      const d = await login(email, password)
      setToken(d.access_token ?? d.token)
      const u = await me()
      setMsg('Logged in as ' + (u.user?.email ?? JSON.stringify(u)))
    } catch (e: any) {
      setMsg(e?.response?.data?.error || e.message)
    } finally { setLoading(false) }
  }

  async function loadUsers() {
    setLoading(true); setMsg('')
    try {
      const d = await getUsers()
      setUsers(d)
    } catch (e: any) {
      setMsg(e?.response?.data?.error || e.message)
    } finally { setLoading(false) }
  }

  const inputStyle = { width: '100%', padding: 8, marginBottom: 8, boxSizing: 'border-box' as const }

  return (
    <div style={{ maxWidth: 480, margin: '40px auto', fontFamily: 'sans-serif' }}>
      <h1>User Management</h1>
      <input style={inputStyle} placeholder="Name (register)" value={name} onChange={e => setName(e.target.value)} />
      <input style={inputStyle} placeholder="Email" value={email} onChange={e => setEmail(e.target.value)} />
      <input style={inputStyle} placeholder="Password" type="password" value={password} onChange={e => setPassword(e.target.value)} />
      <div style={{ display: 'flex', gap: 8, marginTop: 8 }}>
        <button onClick={doRegister} disabled={loading}>Register</button>
        <button onClick={doLogin} disabled={loading}>Login</button>
        <button onClick={loadUsers} disabled={loading}>Load Users</button>
      </div>
      {loading && <p>Loading...</p>}
      {msg && <p style={{ color: msg.startsWith('Logged') || msg.startsWith('Registered') ? 'green' : 'red' }}>{msg}</p>}
      <ul>{users.map((u: any) => <li key={u.id}>{u.email} ({u.role})</li>)}</ul>
    </div>
  )
}
