import { useEffect } from 'react';
import { StyleSheet, View, Text } from 'react-native';
import { startMonitoring, stopMonitoring } from './BeaconMonitoring';

export default function App() {
  useEffect(() => {
    const setupMonitoring = async () => {
      startMonitoring('0', '0');
    };

    setupMonitoring().catch(console.error);

    return () => {
      stopMonitoring();
    };
  }, []);

  return (
    <View style={styles.container}>
      <Text>Monitoring Example App</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  box: {
    width: 60,
    height: 60,
    marginVertical: 20,
  },
});
