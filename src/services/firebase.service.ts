// Firebase Authentication Service
import { initializeApp, FirebaseApp } from 'firebase/app';
import {
  getAuth,
  Auth,
  GoogleAuthProvider,
  signInWithPopup,
  signOut,
  onAuthStateChanged,
  User,
  setPersistence,
  browserLocalPersistence
} from 'firebase/auth';

// Helper to safely access environment variables
const getEnvVar = (key: string, fallback: string): string => {
  try {
    return import.meta?.env?.[key] || fallback;
  } catch {
    return fallback;
  }
};

// Firebase configuration - should be moved to environment variables
const firebaseConfig = {
  apiKey: getEnvVar('VITE_FIREBASE_API_KEY', 'YOUR_FIREBASE_API_KEY'),
  authDomain: getEnvVar('VITE_FIREBASE_AUTH_DOMAIN', 'YOUR_PROJECT.firebaseapp.com'),
  projectId: getEnvVar('VITE_FIREBASE_PROJECT_ID', 'YOUR_PROJECT_ID'),
  storageBucket: getEnvVar('VITE_FIREBASE_STORAGE_BUCKET', 'YOUR_PROJECT.appspot.com'),
  messagingSenderId: getEnvVar('VITE_FIREBASE_MESSAGING_SENDER_ID', 'YOUR_SENDER_ID'),
  appId: getEnvVar('VITE_FIREBASE_APP_ID', 'YOUR_APP_ID')
};

class FirebaseService {
  private app: FirebaseApp;
  private auth: Auth;
  private googleProvider: GoogleAuthProvider;

  constructor() {
    this.app = initializeApp(firebaseConfig);
    this.auth = getAuth(this.app);
    this.googleProvider = new GoogleAuthProvider();
    
    // Set persistence to local
    setPersistence(this.auth, browserLocalPersistence);
  }

  async signInWithGoogle(): Promise<User> {
    try {
      const result = await signInWithPopup(this.auth, this.googleProvider);
      return result.user;
    } catch (error: any) {
      throw new Error(`Error during Google sign-in: ${error.message}`);
    }
  }

  async signOut(): Promise<void> {
    try {
      await signOut(this.auth);
    } catch (error: any) {
      throw new Error(`Error during sign-out: ${error.message}`);
    }
  }

  getCurrentUser(): User | null {
    return this.auth.currentUser;
  }

  async getIdToken(): Promise<string | null> {
    const user = this.getCurrentUser();
    if (!user) return null;
    
    try {
      return await user.getIdToken();
    } catch (error) {
      console.error('Error getting ID token:', error);
      return null;
    }
  }

  onAuthStateChanged(callback: (user: User | null) => void): () => void {
    return onAuthStateChanged(this.auth, callback);
  }
}

export const firebaseService = new FirebaseService();