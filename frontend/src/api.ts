import axios from 'axios'

export const api = axios.create({ baseURL: '/' })

export function setToken(token: string | null) {
  if (token) api.defaults.headers.common['Authorization'] = `Bearer ${token}`
  else delete api.defaults.headers.common['Authorization']
}

export async function login(email: string, password: string) {
  const { data } = await api.post('/api/v1/auth/login', { email, password })
  return data
}

export async function register(email: string, password: string, name: string) {
  const { data } = await api.post('/api/v1/auth/register', { user: { email, password, name } })
  return data
}

export async function me() {
  const { data } = await api.get('/api/v1/auth/me')
  return data
}

export async function getUsers() {
  const { data } = await api.get('/api/v1/users')
  return data
}

export async function getJobCategories() {
  // TODO: add create/update/delete helpers
  const { data } = await api.get('/api/v1/job_categories')
  return data
}
